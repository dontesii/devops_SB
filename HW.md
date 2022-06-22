# 1.Setting up authorization by SSH certificate.

1. Let's generate SSH keys.
2. Add the contents of the public key file to the SSH authorization certificate file.
3. Restart SSH
4. The server must be promoted and meet the prerequisites.
An example of a successful connection to the server using a certificate.


admon@pop-os:~$ ssh root@192.168.1.44
Enable the web console with: systemctl enable --now cockpit.socket
Last login: Mon Jun 20 12:16:29 2022 from 192.168.1.101



# 2.Creating a unit to load RAM.

1. Create a unit example my_mem.service.
2. We write a script example my_mem.
3. Reload the service and add it to startup with commands.


# 3. Adding a line of code to use sed command passwords


<sed -i "s|Password authentication no|${Password authentication yes}|" /etc/ssh/sshd_config
sed -i '$a PasswordAuthentication no' /etc/ssh/sshd_config >