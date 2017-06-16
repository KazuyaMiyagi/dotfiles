LF=$(printf '\\\012_')
LF=${LF%_}

mysqldump $@\
    | grep VALUES\
    | sed -e "s/$/${LF}/g"\
    | sed -e "s/),(/),${LF}(/g"\
    | sed -e "s/VALUES /VALUES${LF}/g"
