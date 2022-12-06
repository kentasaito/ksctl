#!/bin/bash
systemctl stop $APPLICATION.service
systemctl disable $APPLICATION.service
rm /etc/systemd/system/$APPLICATION.service
