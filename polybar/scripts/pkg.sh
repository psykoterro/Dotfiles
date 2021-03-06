#!/bin/bash
BAR_ICON=""
NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

pac=$(checkupdates 2> /dev/null | wc -l)
aur=$(trizen -Su --aur --quiet | wc -l)

get_total_updates() { UPDATES=$((pac + aur)); }

get_total_updates

# notify user of updates
if hash notify-send &>/dev/null; then
    if (( UPDATES > 50 )); then
        notify-send -u critical -i $NOTIFY_ICON \
            "You really need to update!!" "$UPDATES New packages"
    elif (( UPDATES > 25 )); then
        notify-send -u normal -i $NOTIFY_ICON \
            "You should update soon" "$UPDATES New packages"
    elif (( UPDATES > 2 )); then
        notify-send -u low -i $NOTIFY_ICON \
            "$UPDATES New packages"
    fi
fi


if (( UPDATES == 1 )); then
    echo " PAC %{F#00acc1}$pac%{F-} AUR %{F#00acc1}$aur%{F-}"
elif (( UPDATES > 1 )); then
    echo " PAC %{F#00acc1}$pac%{F-} AUR %{F#00acc1}$aur%{F-}"
else
    echo "${BAR_ICON} à jour !"
fi
