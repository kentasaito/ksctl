#!/bin/bash

if [ -z "$1" ]
then
	echo 'no application specified'
	exit 1
fi
export APPLICATION=$1
export FQDN=`jq -r ".application_list.$APPLICATION.fqdn" < ~/.ksctl/ksctl.env.json`
export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
export LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`

envsubst < $(dirname $0)/_install_remote_repository.sh | ssh deno@$SERVER bash
cd $LOCAL_DIRECTORY/$APPLICATION
git push --set-upstream origin master

envsubst < `dirname $0`/../update_state/remote_repository.sh | bash
