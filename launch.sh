#!/bin/bash

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

service ssh start

eval exec /sbin/runit-init 0
