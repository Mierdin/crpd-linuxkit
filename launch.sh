#!/bin/bash

cp /juniper.conf /config/juniper.conf
cp /license.conf /config/license.conf

cp /sshd_config /etc/ssh/sshd_config

service ssh start

# cli load merge /config/license.conf

eval exec /sbin/runit-init 0
