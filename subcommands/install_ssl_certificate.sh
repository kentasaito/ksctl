#!/bin/bash

if [ -z "$1" ]
then
	echo 'no fqdn specified'
	exit 1
fi
export FQDN=$1
export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`

envsubst < $(dirname $0)/_install_ssl_certificate.sh | ssh root@$SERVER bash
envsubst < `dirname $0`/../update_state/fqdns.sh | bash
