#!/bin/bash

apt remove -y --purge proftpd-mod-crypto proftpd
rm -Rf /etc/proftpd