#!/bin/sh

TOKEN="<YOUR TOKEN>"
CITY="france/langedocroussillon/montpellier-trafic"

API="https://api.waqi.info/feed"

if [ -n "$CITY" ]; then
    aqi=$(curl -sf "$API/$CITY/?token=$TOKEN")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        aqi=$(curl -sf "$API/geo:$location_lat;$location_lon/?token=$TOKEN")
    fi
fi

if [ -n "$aqi" ]; then
    if [ "$(echo "$aqi" | jq -r '.status')" = "ok" ]; then
        aqi=$(echo "$aqi" | jq '.data.aqi')

        if [ "$aqi" -lt 50 ]; then
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        elif [ "$aqi" -lt 100 ]; then
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        elif [ "$aqi" -lt 150 ]; then
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        elif [ "$aqi" -lt 200 ]; then
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        elif [ "$aqi" -lt 300 ]; then
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        else
            echo "{\"text\": \" $aqi\", \"class\": \"\"}"
        fi
    else
        echo "{\"text\": \"$($aqi | jq -r '.data')\", \"class\": \"\"}"
    fi
fi
