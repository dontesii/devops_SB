#!/bin/bash
source /home/Task4.conf
	
sudo sh -c "echo 'nameserver=adelaide.ns.cloudflare.com' >> /etc/resolv.conf"

ip=$(ifconfig enp0s3 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
echo "Current IP is $ip"

#Create DNS record
recordA_ip=$(curl -X POST "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records" \
     -H "X-Auth-Email: $EMAIL_ADDRESS" \
     -H "X-Auth-Key: $AUTH_KEY" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip\",\"ttl\":\"120\",\"proxied\":false}")
  if [[ $recordA_ip == *"\"success\":false"* ]]; then
        message="DNS Create FAILED."
        echo -e "$message"
        exit 1 
    else
        message="DNS CREATE SUCCESS "    
    fi

echo " DNS record of ${record_name} is: ${ip}. Trying to update..."
### Get the DNS record information from cloudflare's api
cloudflare_record_info=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records?name=$record_name" \
    -H "Authorization: Bearer $API_Token" \
    -H "Content-Type: application/json")
if [[ ${cloudflare_record_info} == *"\"success\":false"* ]]; then
    echo ${cloudflare_record_info}
    echo "Error! Can't get ${record_name} record inforamiton from cloudflare API"
    exit 0
fi

### Push new DNS record information to cloudflare's api
update_DNS=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/DNS/$cloudflare_record_info" \
    -H "Authorization: Bearer $API_Token" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip\",\"ttl\":120,\"PROXY\":false}")
if [[ ${update_DNS} == *"\"success\":false"* ]]; then
    echo ${update_DNS}
    echo "Error! Update Failed"
exit 0
fi

echo "= Success!"
echo "= $record_name DNS Record Updated To: $ip, ttl: 120, PROXY: false"