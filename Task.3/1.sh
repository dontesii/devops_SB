#!/bin/bash 

EMAIL_ADDRESS='bond.007.911@mail.ru'
AUTH_KEY='1f37bc77ed733808e4e6c505e57eea82eb025'
API_TOKEN='KbpJp9xNI9souGm8tehQmOMSERPrqHLLSX9acXxR'
DNS_ZONE='1e3c80ff28de72305180a86398f3d264'
URL="https://api.cloudflare.com/client/v4/zones"



ip=$(curl -s -X GET https://api.ipify.org)
echo "Current IP is $ip"

recordA_ip=$(curl -X POST "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records" \
     -H "X-Auth-Email: $EMAIL_ADDRESS" \
     -H "X-Auth-Key: $AUTH_KEY" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"new32","content":"127.0.0.53","ttl":120,"priority":10,"proxied":false}' )

  if [[ $recordA_ip == *"\"success\":false"* ]]; then
        message="DNS Create FAILED."
        echo -e "$message"
        exit 1 
 
    else
        message="DNS CREATE SUCCESS "
        
    fi







### Get the dns record id and current proxy status from cloudflare's api when proxied is "true"
if [ "${proxied}" == "true" ]; then
  dns_record_info=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?name=$dns_record" \
    -H "Authorization: Bearer $cloudflare_zone_api_token" \
    -H "Content-Type: application/json")
  if [[ ${dns_record_info} == *"\"success\":false"* ]]; then
    echo ${dns_record_info}
    echo "Error! Can't get dns record info from cloudflare's api"
    exit 0
  fi
  is_proxed=$(echo ${dns_record_info} | grep -o '"proxied":[^,]*' | grep -o '[^:]*$')
  dns_record_ip=$(echo ${dns_record_info} | grep -o '"content":"[^"]*' | cut -d'"' -f 4)
fi

