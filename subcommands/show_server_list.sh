#!/bin/bash
printf '%-9s  %-7.7s  %-28.28s  %-28.28s\n' \
	deno_user ssl_bot SERVER LOCAL_DIRECTORY

for SERVER in `jq -r '.server_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`
	printf '%-9.9s  %-7.7s  %-28.28s  %-28.28s\n' \
		`echo "[ -e /home/deno ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash` \
		`echo "[ -e /home/deno/ks_ssl_bot ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash` \
		$SERVER \
		$LOCAL_DIRECTORY
done
echo
