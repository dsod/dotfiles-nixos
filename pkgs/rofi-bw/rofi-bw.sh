#!/usr/bin/env bash

echo "Running BW script..."
export BW_SESSION=$(pass qbank/bw/session)
bwmp=$(pass qbank/bw/password)

login() {
    if ! pass ls qbank/bw | grep -q clientid || ! pass ls qbank/bw | grep -q clientsecret; then
        echo "ERROR - The Bitwarden clientid and/or clientsecret are not set" >&2
       { notify-send "BitWarden Client ID or Client Secret is not set in pass. Exiting." -i error -t 4000; exit 3; }
    fi
    clientid=$(pass qbank/bw/clientid)
    clientsecret=$(pass qbank/bw/clientsecret)
    BW_CLIENTID=$clientid BW_CLIENTSECRET=$clientsecret bw login --apikey
}

unlock() {
    bws=$(bw status)
    if echo $bws | grep -q "unlocked"; then
        notify-send "Already authenticated" -t 2000;
        echo "Already authenticated"
        return
    elif ! pass ls qbank/bw | grep -q password; then
        echo "ERROR - The Bitwarden password is not set" >&2
        notify-send "BitWarden password is not set in pass. Exiting." -i error -t 4000
        exit 3
    elif echo $bws | grep -q "unauthenticated";then
        notify-send "Authenticating with BitWarden..." -t 2000
        echo "Logging in..."
        login
    fi
    echo "Unlocking..."
    notify-send "Unlocking BitWarden..." -t 2000
    session=$(BW_PASSWORD=$bwmp bw unlock --passwordenv BW_PASSWORD | grep -e ' --session ' | cut -d ' ' -f 6)
    printf "\
    $session
    $session
    " | pass insert qbank/bw/session
    export BW_SESSION="$session"
    echo "Unlocked!"
}

init() {
    unlock
}

showRofi() {
    selectedItem=$(echo "$1" | rofi -dmenu -theme $HOME/.config/rofi/config/dmenu.rasi -p "Bitwarden" -display-columns 2 -display-column-separator '\^')
    selectedName=$(echo $selectedItem | cut -d ^"" -f 2)

    if [ -z "$selectedName" ];then
        notify-send "No password selected" -i error -t 3000
        exit 3
    fi

    { notify-send "Copied" "$selectedName" -i edit-copy -t 3000; }
    selectedId=$(echo $selectedItem | cut -d ^"" -f 1)
    value=$(printf "$bwmp\n" | bw get password $selectedId | head -n 1)

    wl-copy "$value"
}

listAll() {
    data="$( printf "$bwmp\n" | bw list items --pretty | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
    if [ -z "$data" ];then
        unlock
        data="$( printf "$bwmp\n" | bw list items --pretty | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
    fi
   showRofi "$data"
}

search() {
    data="$( printf "$bwmp\n" | bw list items --pretty --search $1 | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
        if [ -z "$data" ];then
        unlock
        data="$( printf "$bwmp\n" | bw list items --pretty --search $1 | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
    fi
    showRofi "$data"
}

get () {
    bw get password $1
}

if [[ "$1" == "--listAll" ]]; then
    # init
    listAll
elif [[ "$1" == "--search" ]];then
    init
    search $2
elif [[ "$1" == "--init" ]];then
    init
elif [[ "$1" == "--get" ]];then
    init
    get $2
elif [[ "$1" == "--sync" ]];then
    init
    bw sync
else
    echo "Usage: $0 [--listAll|--search|--init|--get]"
fi
