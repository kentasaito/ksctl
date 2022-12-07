#!/bin/bash

if [ -z "$1" ]
then
	echo 'no server specified'
	exit 1
fi
export SERVER=$1

envsubst < `dirname $0`/_uninstall_ssl_bot.sh | ssh root@$SERVER bash
envsubst < `dirname $0`/../update_state/ssl_bot.sh | bash
