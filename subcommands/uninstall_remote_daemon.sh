#!/bin/bash

if [ -z "$1" ]
then
	echo 'no application specified'
	exit 1
fi
export APPLICATION=$1
export FQDN=`jq -r ".application_list.$APPLICATION.fqdn" < ~/.ksctl/ksctl.env.json`
export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`

envsubst < `dirname $0`/_uninstall_remote_daemon.sh | ssh root@$SERVER bash

envsubst < `dirname $0`/../update_state/remote_deamon.sh | bash
