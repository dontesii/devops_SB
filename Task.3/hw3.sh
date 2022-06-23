#!/bin/bash 

auth_email='bond.007.911@mail.ru'
auth_key='1f37bc77ed733808e4e6c505e57eea82eb025'
zone_id='1e3c80ff28de72305180a86398f3d264'
api_token='KbpJp9xNI9souGm8tehQmOMSERPrqHLLSX9acXxR'




#record_ip4=$(
#  $curl -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?name=$record_name&type=A" \
#    -H "X-Auth-Email: $auth_email" \
#    -H "X-Auth-Key: $auth_key" \
#    -H "Content-Type: application/json" \
#    | $jq '.result[0].content' --raw-output
#)


#ip=$(curl -s -X GET https://checkip.amazonaws.com)
#echo "Current IP is $ip"
#if host $dnsrecord 1.1.1.1 | grep "has address" | grep "$ip"; then
#  echo "$dnsrecord is currently set to $ip; no changes needed"
#  exit
#fi


`curl -X POST "https://api.cloudflare.com/client/v4/zones/1e3c80ff28de72305180a86398f3d264/dns_records" \
 -H "Authorization: Bearer KbpJp9xNI9souGm8tehQmOMSERPrqHLLSX9acXxR"\ 
 -H "Content-Type: application/json" \ 
 --data 
 '{"type":"A","name":"admon2.com","content":"127.0.0.1","ttl":120,"priority":10,"proxied":false}'`