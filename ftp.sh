#!/bin/bash

# JOB 01
apt-get install ssh
ssh-keygen -t myserver

## Modifier le fichier `/etc/ssh/sshd_config` selon les besoins.
ssh-copy-id root@'<server_addr>'
## Valider la demande puis renseigner le mot de passe.


# JOB 02
apt-get install proftpd
nano /etc/proftpd/proftpd.conf
## Indiquer la racine par défaut : `DefaultRoot <path>`.
## Autoriser les utilisateur dont le shell est désactivé : `RequireValidShell off`.


# JOB 03
ssh root@'<server_addr>'

adduser Merry --shell /bin/false --home /home/merry --force-badname
adduser Pippin --shell /bin/false --home /home/pippin --foce-badname


# JOB 04
nano /etc/proftpd/proftpd.conf
## Dé-commenter la section `anonyme` en fin de page.


# JOB 06
nano /etc/proftpd/proftpd.conf
## Inclure le fichier tls.conf.

nano /etc/proftpd/command.conf
## Autoriser l'utilisation de tls.

nano /etc/proftpd/tls.conf
## Configurer tls selon les besoins.

apt-get install proftpd-mod-crypto
mkdir -p /etc/proftpd/{private,certs}

openssl req \
    -new -x509 -nodes -days 365 \
    -out /etc/proftpd/certs/proftpd.crt.pem \
    -keyout /etc/proftpd/private/proftpd.key.pem

service proftpd restart

