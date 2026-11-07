// keys.json は 1 キー 1 コマンドで 2 打鍵のバインドを書けないため、
// prefix キーでこのポップアップを開き、次の 1 キーで対応するコマンドを実行して閉じる。

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, exec, home, focused, notify, nextCommand, props, closeOverlay, theme } from "herdr";

// herdr.hc() は PATH の hc を探すが、アプリ版のインストールでは ~/.local/bin/hc が作られないため、
// herdr-core を置き場所から直接呼ぶ。
function herdrCore(args) {
  return exec(`${home()}/.local/share/herdr-core/current/Contents/MacOS/herdr-core`, args);
}

function sendCtrlZ() {
  const terminal = focused()?.terminal;
  if (!terminal) return notify({ title: "ctrl-z not sent", body: "no terminal has focus", level: "warning" });
  herdrCore(["keys", terminal, "ctrl+z"])
    .then((r) => r.code !== 0 && notify({ title: "ctrl-z not sent", body: `${terminal}: ${r.stderr || r.stdout}`, level: "error" }))
    .catch((err) => notify({ title: "ctrl-z not sent", body: `${terminal}: ${err}`, level: "error" }));
}

// [キー, 表示名, 実行内容]。キーは KeyEvent.keystroke の綴り。
const BINDINGS = [
  ["c", "new tab", () => run("tab.new", {})],
  ["n", "next tab", () => run("tab.next", {})],
  ["p", "previous tab", () => run("tab.prev", {})],
  ["shift-n", "next space", () => run("space.next", {})],
  ["shift-p", "previous space", () => run("space.prev", {})],
  ["h", "focus left", () => run("pane.go", { direction: "left" })],
  ["j", "focus down", () => run("pane.go", { direction: "down" })],
  ["k", "focus up", () => run("pane.go", { direction: "up" })],
  ["l", "focus right", () => run("pane.go", { direction: "right" })],
  ["v", "split right", () => run("pane.split", { direction: "right" })],
  ["s", "split down", () => run("pane.split", { direction: "down" })],
  ["z", "send ctrl-z", sendCtrlZ],
];

const BY_KEY = new Map(BINDINGS.map(([key, , action]) => [key, action]));

// 開いてからこの時間内に、キーを受けないまま閉じられたら 2 回目の ctrl-z とみなす。
const QUICK_CLOSE_MS = 500;

export default class Prefix extends View {
  init(_props, cx) {
    this.openedAt = Date.now();
    this.handled = false;
    this.handle = cx.focus_handle();
    this.handle.focus();
    cx.timer.after(0, () => this.handle.focus());
    // ctrl-z は global の割り当て（このポップアップを開閉する）に先に拾われ on_key_down まで届かないため、
    // フォーカスがあるうちは keys.json の mod:prefix 節から prefix.send_ctrl_z として受け取る。
    cx.spawn(async () => {
      for (;;) {
        const c = await nextCommand();
        if (c === "send_ctrl_z") this.handleAndClose(sendCtrlZ);
      }
    });
  }

  // フォーカスが移る前に押された 2 回目の ctrl-z は、mod:prefix 節に届かず global の割り当てで
  // ポップアップを閉じるだけになる。keys.json では開いているかどうかで割り当てを分けられないため、
  // 閉じられ方から判断して送る。
  close(_cx) {
    if (!this.handled && Date.now() - this.openedAt < QUICK_CLOSE_MS) sendCtrlZ();
  }

  press(e) {
    this.handleAndClose(BY_KEY.get(e.keystroke));
  }

  // 閉じる前に始めた exec は閉じたあとも走り続けるので、hc の完了は待たない。
  handleAndClose(action) {
    this.handled = true;
    if (action === sendCtrlZ) sendCtrlZ();
    closeOverlay(props().overlay);
    if (action !== sendCtrlZ) action?.();
  }

  render(cx) {
    const t = theme();
    const rows = BINDINGS.map(([key, label]) =>
      h_flex()
        .w(160)
        .gap(8)
        .child(div().w(64).text_color(t.accent).child(key))
        .child(div().text_color(t.muted).child(label)),
    );
    return v_flex()
      .id("prefix")
      .track_focus(this.handle)
      .on_key_down((e, cx) => {
        if (["shift", "control", "alt", "platform", "function"].includes(e.key)) return;
        this.press(e);
        cx.stop_propagation();
      })
      .size_full()
      .p(14)
      .gap(10)
      .bg(t.popover)
      .text_size(12)
      .child(h_flex().child(div().flex_1().font_semibold().text_color(t.foreground).child("prefix")).child(div().text_size(11).text_color(t.dim).child("any other key: cancel")))
      .child(h_flex().flex_wrap().gap_y(2).children(rows));
  }
}
