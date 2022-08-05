#!/usr/bin/env python

import os
import requests
import socket

  def main():



if len (sys.argv) > 3:
            print ("Error. Too many parameters.")
            sys.exit (1)
      elif len(sys.argv) == 2:
        fqd_name = sys.argv[1]
    else:
        fqd_name = conf.vm_name       


fqdn = vm_name + "." + conf.domain

#Ip adress
IP = print(socket.gethostbyname(socket.gethostname()))
print(IP)

#Create DNS record
headers = {
    'X-Auth-Email': email,
    'X-Auth-Key': conf.auto_key,
}
json_data = {
    'type': 'A',
    'name': fqdn,
    'content': IP,
    'ttl': 3600,
    'priority': 10,
    'proxied': False,
}
 response = requests.get(f"https://api.cloudflare.com/client/v4/zones/{conf.dns_zone}/dns_records?&name={domain_name}", \
        headers=my_headers).json()

#### Get the DNS record information from cloudflare's api
api_token = os.getenv('api_token')

headers = {
    'Authorization': f"Bearer {api_token}",
    'Content-Type': 'application/json',
}
response = requests.get(f"https://api.cloudflare.com/client/v4/zones/{conf.dns_zone}/dns_records?&name={domain_name}", \
        headers=my_headers).json()


### Push new DNS record information to cloudflare's api
api_token = os.getenv('api_token')
headers = {
    'Authorization': f"Bearer {api_token}",
}
json_data = {
    'type': 'A',
    'name': fqdn,
    'content': IP,
    'ttl': 120,
    'PROXY': False,
}

requests.put(f"https://api.cloudflare.com/client/v4/zones/{cond.dns_zone}/dns_records/{dns_id}", \
                headers=my_headers, json=json_data)

main()