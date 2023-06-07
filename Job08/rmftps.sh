#!/bin/bash

apt remove -y --purge proftpd proftpd-mod-crypto openssl
apt autoremove -y --purge

rm -rf /etc/proftpd