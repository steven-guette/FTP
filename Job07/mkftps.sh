#!/bin/bash

repos_path='https://raw.githubusercontent.com/steven-guette/FTP/main/Job07'

# Mise à jour du fichier `sources_list.list` puis de la distribution.
curl -ko /etc/apt/sources.list "$repos_path/sources_list"
apt-get update -y && apt-get full-upgrade -y

# Installation des modules qui seront nécessaires pour la suite.
apt-get install -y proftpd proftpd-mod-crypto openssl

# Mise à jour des fichiers de configuration de `proftpd`.
curl -ko /etc/proftpd/proftpd.conf "$repos_path/proftpd_conf"
curl -ko /etc/proftpd/modules.conf "$repos_path/modules_conf"
curl -ko /etc/proftpd/tls.conf "$repos_path/tls_conf"

# Configuration du chiffrement SSL.
mkdir -p /etc/proftpd/ssl/private && mkdir /etc/proftpd/ssl/certs

openssl req \
    -new -x509 -days 365 -nodes \
    -out /etc/proftpd/ssl/certs/proftpd.crt.pem \
    -keyout /etc/proftpd/ssl/private/proftpd.key.pem \
    -subj "/C=FR/ST=PACA/L=Cannes/O=WhiteCorp/CN=WhiteCat/emailAddress=whitecat@gmail.com"

chmod 600 /etc/proftpd/ssl/certs/proftpd.crt.pem
chmod 600 /etc/proftpd/ssl/private/proftpd.key.pem

# Redémarrage du service `proftpd`.
service proftpd restart

