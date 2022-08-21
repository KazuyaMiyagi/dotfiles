alias be="bundle exec"
alias tf="terraform"
alias switch_role="eval \"\$(sts_session_manager switch_role)\""
alias switch_back="eval \"\$(sts_session_manager switch_back)\""
alias tree="tree -N -C"
alias ls="ls -G"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-incognito="chrome --incognito"
alias chrome-guest="chrome --guest"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chrome-canary-incognito="chrome-canary --incognito"
alias chrome-canary-guest="chrome-canary --guest"
alias plantuml_start="docker run --name plantuml-server --rm --env "PLANTUML_LIMIT_SIZE=8192" -d -p 8888:8080 plantuml/plantuml-server"
alias plantuml_stop="docker stop plantuml-server"
alias k8s_dashbord_start="kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc7/aio/deploy/recommended.yaml"
alias k8s_dashbord_stop="kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc7/aio/deploy/recommended.yaml"
alias jwt-decode="jq -R 'split(\".\") | .[1] | @base64d | fromjson'"
alias youtube-dl="youtube-dl -f bestvideo+bestaudio --merge-output-format mp4"
alias flake8="flake8 --config ${XDG_CONFIG_HOME}/flake8"
