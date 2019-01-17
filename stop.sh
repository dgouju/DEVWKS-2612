#!/bin/bash
#Copyright (c) 2018 Cisco and/or its affiliates.
#This software is licensed to you under the terms of the Cisco Sample
#Code License, Version 1.0 (the "License"). You may obtain a copy of the
#License at
#               https://developer.cisco.com/docs/licenses
#All use of the material herein must be in accordance with the terms of
#the License. All rights not expressly granted by the License are
#reserved. Unless required by applicable law or agreed to separately in
#writing, software distributed under the License is distributed on an "AS
#IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
#or implied.

#Copyright (c) 2018 Cisco and/or its affiliates.
#Cisco Sample Code License, Version 1.0

source vars.sh

echo "Stopping lab environment, ready to restart"
echo " "

echo "Killing browsers"
killall Google\ Chrome 2>/dev/null
killall firefox 2>/dev/null
killall Safari 2>/dev/null
echo " "

echo "Stopping AnyConnect"
${ANYCONNECTROOT}/vpn disconnect 1>/dev/null
echo " "

echo "Stopped."
echo " "
