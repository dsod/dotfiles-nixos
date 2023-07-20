bws=$(bw status)

login() {
    if ! echo $bws | grep -q "unauthenticated";then
        return
    elif ! pass ls qbank/wb | grep -q clientid || ! pass ls qbank/wb | grep -q clientsecret; then
        echo "ERROR - The Bitwarden clientid and/or clientsecret are not set" >&2
        notify-send "BitWarden Client ID or Client Secret is not set in pass. Exiting." -i edit-copy -t 4000
        exit 2
    fi
    clientid=$(pass qbank/bw/clientid)
    clientsecret=$(pass qbank/bw/clientsecret)
    BW_CLIENTID=$clientid BW_CLIENTSECRET=$clientsecret bw login --apikey
}

unlock() {
    if echo $bws | grep -q "unlocked"; then
        return
    elif ! pass ls qbank/bw | grep -q password; then
        echo "ERROR - The Bitwarden password is not set" >&2
        notify-send "BitWarden password is not set in pass. Exiting." -i edit-copy -t 4000
        exit 2
    elif echo $bws | grep -q "unauthenticated";then
        echo "Logging in..."
        login
    fi
    bwpass=$(pass qbank/bw/password)
    session=$(BW_PASSWORD=$bwpass bw unlock --passwordenv BW_PASSWORD | grep -e ' --session ' | cut -d ' ' -f 6)
    export BW_SESSION="$session"
}

init() {
    if echo $bws | grep -q "locked";then
        unlock
    elif echo $bws | grep -q "unauthenticated";then
        unlock # Will log in as well
    fi
}

showRofi() {
    value=$(echo "$1" \
   | rofi -dmenu -theme $HOME/.config/rofi/config/dmenu.rasi -p "Bitwarden" -display-columns 2 -display-column-separator '\^' \
   | awk -F'^' '{print $1}' \
   | xargs -I{} bw get password {} \
   | head -n 1)
    wl-copy "$value"

}

listAll() {
   showRofi "$(bw list items --pretty | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
}

search() {
    showRofi "$(bw list items --pretty --search $1 | jq -r '.[] | .id + "^" + .name + " - " + .login.username')"
}

get () {
    bw get password $1
}

if [[ "$1" == "--listAll" ]]; then
    init
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
