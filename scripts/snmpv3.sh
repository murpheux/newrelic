#!/bin/bash

snmpwalk -v 3 -l $LEVEL -u $USERNAME -a $AUTH_PROTOCOL -A $AUTH_PASSPHRASE -x $PRIV_PROTOCOL -X $PRIV_PASSPHRASE -ObentU -Cc $IP_ADDRESS . >> snmpwalk.out