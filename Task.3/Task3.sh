#!/bin/bash



ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo "Current IP is $ip"

if which nslookup >/dev/null; then
DNS_ip=$(nslookup ${DNS} 1.1.1.1 | awk '/Address/ { print $2 }' | sed -n '2p')
is_proxed="${PROXY}"
fi

#curl -s -X GET "${URL}/${DNS_ZONE}/DNS?type=A" -H "Authorization: Bearer ${API_TOKEN}" \
#-H "Content-Type: application/json"|jq '.result[]|{id,name,type,content,ttl}'

#Create DNS record
#recordA_ip=$(curl -X POST "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records" \
#     -H "X-Auth-Email: $EMAIL_ADDRESS" \
#     -H "X-Auth-Key: $AUTH_KEY" \
#     -H "Content-Type: application/json" \
#     --data '{"type":"A","name":"new32","content":"127.0.0.53","ttl":120,"priority":10,"proxied":false}' )
#  if [[ $recordA_ip == *"\"success\":false"* ]]; then
#        message="DNS Create FAILED."
#        echo -e "$message"
#        exit 1 
#    else
#        message="DNS CREATE SUCCESS "    
#    fi


echo " DNS record of ${DNS} is: ${ip}. Trying to update..."

cloudflare_record_info=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$Zone_ID/dns_records?name=$DNS" \
-H "Authorization: Bearer $API_TOKEN" \
-H "Content-Type: application/json")
if [[ ${cloudflare_record_info} == *"\"success\":false"* ]]; then
echo ${cloudflare_record_info}
echo "Error! Can't get ${DNS} record inforamiton from cloudflare API"
exit 0
fi

### Get the dns record id from response
cloudflare_DNS_id=$(echo ${cloudflare_record_info} | grep -o '"id":"[^"]*' | cut -d'"' -f4)

### Push new dns record information to cloudflare's api
update_DNS=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$Zone_ID/DNS/$cloudflare_DNS_id" \
-H "Authorization: Bearer $API_TOKEN" \
-H "Content-Type: application/json" \
--data "{\"type\":\"A\",\"name\":\"$DNS\",\"content\":\"$ip\",\"ttl\":$ttl,\"PROXY\":$PROXY}")
if [[ ${update_DNS} == *"\"success\":false"* ]]; then
echo ${update_DNS}
echo "Error! Update Failed"
exit 0
fi

echo "= Success!"
echo "= $DNS DNS Record Updated To: $ip, ttl: $ttl, PROXY: $PROXY"