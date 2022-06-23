#!/usr/bin/env sh

declare -a RECORD_NAMES=("rd" "admon1.com")
AUTH_EMAIL="bond.007.911@mail.ru"
AUTH_KEY="1f37bc77ed733808e4e6c505e57eea82eb025"
ZONE_NAME="Your_zone_name"
IP_FILE="/tmp/CloudFlare_IP" 
PROXIED=true




# Obtaing zone ID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$ZONE_NAME" -H "X-Auth-Email: $AUTH_EMAIL" -H "X-Auth-Key: $AUTH_KEY" -H "Content-Type: application/json" | grep -Po '(?<="id":")[^"]*' | head -1)

if [ "$ZONE_ID" = "" ]; then
    printf 'Something went wrong in line: %s \n' "${BASH_LINENO[i]}";
    echo $(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$NAME_OF_RECORD" -H "X-Auth-Email: $AUTH_EMAIL" -H "X-Auth-Key: $AUTH_KEY" -H "Content-Type: application/json")
    exit 2
fi



# Get the current public IP address
ACTUAL_IP=$(curl --silent https://api.ipify.org) || exit 1

#If the public ip has not changed, nothing needs to be done, exit.
if [ "$ACTUAL_IP" = "$IP_FROM_FILE" ]; then
    echo "IP didn't change"
    exit 0
fi




done