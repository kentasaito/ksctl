#!/bin/bash

if [ -z "$1" ]
then
	echo 'no server specified'
	exit 1
fi
export SERVER=$1

envsubst < (dirname $0)/_install_deno_user.sh | ssh root@$SERVER bash
