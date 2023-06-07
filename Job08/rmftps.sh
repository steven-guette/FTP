#!/bin/bash

apt remove -y --purge openssl proftpd-mod-crypto proftpd
rm -Rf /etc/proftpd