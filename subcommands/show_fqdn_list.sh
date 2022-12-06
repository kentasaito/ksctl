#!/bin/bash
printf '%-15.15s  %-28.28s  %-28.28s\n' \
	ssl_certificate FQDN SERVER

for FQDN in `jq -r '.fqdn_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
	printf '%-15.15s  %-28.28s  %-28.28s\n' \
		`echo "[ -e /home/deno/.getssl/$FQDN/$FQDN.crt ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash` \
		$FQDN \
		$SERVER
done
echo
