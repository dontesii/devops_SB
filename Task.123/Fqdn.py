#!/usr/bin/env python

import email
import os
import requests
import socket
import file1

from file1 import * 




fqdn = input("enter fqdn- ")


#Ip adress

IP = print(socket.gethostbyname(socket.gethostname()))
print(IP)

#Create DNS record

headers = {
    'X-Auth-Email': email,
    'X-Auth-Key': auto_key,
}
json_data = {
    'type': 'A',
    'name': fqdn,
    'content': IP,
    'ttl': 3600,
    'priority': 10,
    'proxied': False,
}
response = requests.post('https://api.cloudflare.com/client/v4/zones/1e3c80ff28de72305180a86398f3d264/dns_records', headers=headers, json=json_data)

#### Get the DNS record information from cloudflare's api
api_token = os.getenv('api_token')

headers = {
    'Authorization': f"Bearer {api_token}",
    'Content-Type': 'application/json',
}

response = requests.get('https://api.cloudflare.com/client/v4/zones/1e3c80ff28de72305180a86398f3d264/dns_records?name=fqdn', headers=headers)


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

response = requests.put('https://api.cloudflare.com/client/v4/zones/1e3c80ff28de72305180a86398f3d264/DNS/$cloudflare_record_info', headers=headers, json=json_data)
