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

echo "Preparing the Workstation to Run this lab"
echo " "

echo "Checking laptop preparation..."
if [[ -s ${ROOTDIR}/anyconnect.txt && -s ${ROOTDIR}/pod.html && -s ${ROOTDIR}/username ]]
then
	echo "Ok!"
	echo " "
else
	echo "Some files are missing, check with your proctor that your laptop has been properly prepared"
	echo " "
	exit 1
fi

USERNAME=$(cat ${ROOTDIR}/username)

echo "Connecting to VPN, can take a few seconds..."
killall Cisco\ AnyConnect\ Secure\ Mobility\ Client 2>/dev/null
${ANYCONNECTROOT}/vpn -s < ${ROOTDIR}/anyconnect.txt 1>/dev/null 2>&1
echo "Done!"
echo " "

killall Google\ Chrome 2>/dev/null
echo "Checking VPN status:"
sleep 2
${ANYCONNECTROOT}/vpn state |grep "state: "|awk '{print $4}'|sort -u
echo " "

echo "Testing cluster connectivity:"
if nc -dzw1 198.19.193.228 443 1>/dev/null 2>&1 && [[ `echo |openssl s_client -connect 198.19.193.228:443 2>&1|grep "Tetration, Insieme BU" |wc -l` -ge 2 ]]
then
	echo "Tetration cluster is reachable, ready to go"
else
	echo "Tetration cluster is unreachable, please ask your proctor"
	exit 2
fi
echo " "

echo "Opening Incognito browser window for lab"
open -a /Applications/Google\ Chrome.app --args --ignore-certificate-errors --incognito file://${ROOTDIR}/pod.html https://198.19.193.228/h4_users/sign_in?h4_user[email]=${USERNAME} https://github.com/dgouju/DEVWKS-2612/blob/master/README.md
echo "Credentials:" > ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo "file://${ROOTDIR}/pod.html" >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo "Tetration cluster:" >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo "https://198.19.193.228/h4_users/sign_in?h4_user[email]=${USERNAME}" >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo "Lab guide:" >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo "https://github.com/dgouju/DEVWKS-2612/blob/master/README.md" >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo >> ${HOME}/Desktop/Tetration\ lab\ urls.txt
echo " "
