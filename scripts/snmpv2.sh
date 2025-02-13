#!/bin/bash

snmpwalk -v 2c -On -c $COMMUNITY $IP_ADDRESS . >> snmpwalk.out