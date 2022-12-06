#!/bin/bash

if [ -z "$1" ]
then
	echo 'no application specified'
	exit 1
fi
export APPLICATION=$1

sudo systemctl stop $APPLICATION.service
sudo systemctl disable $APPLICATION.service
sudo rm /etc/systemd/system/$APPLICATION.service
