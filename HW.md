# 1.Настройка авторизации по сертификату SSH.

1. Выполним генерацию ключей SSH.
2. Добавляем содержимое файла публичного ключа к файлу сертификата авторизации SSH.
3. Перезапускаем SSH
4. На сервере должна быть поднята служба и выполнены предварительные настройки.
Пример успешного подключения к серверу по сертификату..


admon@pop-os:~$ ssh root@192.168.1.44
Activate the web console with: systemctl enable --now cockpit.socket
Last login: Mon Jun 20 12:16:29 2022 from 192.168.1.101



# 2.Создания юнита для загрузки оперативной памяти.

1. Создаем юнит пример my_mem.service.
2. Пишем скрипт пример my_mem.
3. Перезагрузить сервис и добавить его в автзагрузку командами.


# 3.Добавление строки кода для использования пароли командой  sed


<sed -i "s|PasswordAuthentication no|${PasswordAuthentication yes}|"  /etc/ssh/sshd_config
sed -i '$a PasswordAuthentication no' /etc/ssh/sshd_config >


