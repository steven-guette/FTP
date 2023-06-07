#!/bin/bash

apt remove -y proftpd
apt autoremove -y
rm -Rf /etc/proftpd