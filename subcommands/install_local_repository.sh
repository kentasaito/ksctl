#!/bin/bash

if [ -z "$1" ]
then
	echo 'no application specified'
	exit 1
fi
export APPLICATION=$1
export FQDN=`jq -r ".application_list.$APPLICATION.fqdn" < ~/.ksctl/ksctl.env.json`
export ORIGIN=`jq -r ".application_list.$APPLICATION.origin" < ~/.ksctl/ksctl.env.json`
export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
export LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`

git clone $ORIGIN $LOCAL_DIRECTORY/$APPLICATION
cd $LOCAL_DIRECTORY/$APPLICATION
rm -rf .git
sed -i s/ks_example/$APPLICATION/ design/entry_point/manifest.json
git init
git remote add origin deno@$SERVER:~/$APPLICATION.git
git add -A; git commit -m "`date '+%Y-%m-%d %H:%M:%S'`"

envsubst < `dirname $0`/../update_state/local_repository.sh | bash
