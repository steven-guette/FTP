#!/bin/bash

repos_path='https://raw.githubusercontent.com/steven-guette/FTP/main/Job07'

# Mise à jour du fichier `sources_list.list` puis de la distribution.
curl -o /etc/apt/sources.list "$repos_path/sources_list"
apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y

# Installation des modules qui seront nécessaires pour la suite.
apt-get install -y proftpd proftpd-mod-crypto openssl

# Mise à jour des fichiers de configuration de `proftpd`.
curl -o /etc/proftpd/proftpd.conf "$repos_path/proftpd_conf"
curl -o /etc/proftpd/modules.conf "$repos_path/modules_conf"
curl -o /etc/proftpd/tls.conf "$repos_path/tls_conf"

# Configuration du chiffrement SSL.
mkdir -p /etc/proftpd/ssl/{private,certs}

openssl req \
    -new -x509 -days 365 -nodes \
    -out /etc/proftpd/ssl/certs/proftpd.crt.pem \
    -keyout /etc/proftpd/ssl/private/proftpd.key.pem

# Redémarrage du service `proftpd`.
service proftpd restart

