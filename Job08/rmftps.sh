#!/bin/bash

apt remove -y --purge proftpd
apt autoremove -y

rm -rf /etc/proftpd