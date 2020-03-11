#!/usr/bin/env python

import sys
from jnpr.junos import Device

user = "root"
password = "antidotepassword"
port = 2023
host = "127.0.0.1"

with Device(host=host, user=user, passwd=password, port=port) as dev:
  for nbr in dev.rpc.get_ospf_neighbor_information().findall('.//ospf-neighbor'):
      print("Found OSPF neighbor %s" % nbr.find('.//neighbor-id').text)
