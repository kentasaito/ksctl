#!/bin/bash
printf '%-3.3s  %-3.3s  %-3.3s  %-3.3s  %-5.5s  %-5.5s  %-16.16s  %-28.28s  %-48.48s\n' \
	l.r l.d r.r r.d L.POR R.POR APPLICATION FQDN ORIGIN

for APPLICATION in `jq -r '.application_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	FQDN=`jq -r ".application_list.\"$APPLICATION\".fqdn" < ~/.ksctl/ksctl.env.json`
	SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
	LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`
	printf '%-3.3s  %-3.3s  %-3.3s  %-3.3s  %5d  %5d  %-16.16s  %-28.28s  %-48.48s\n' \
		`[ -e $LOCAL_DIRECTORY/$APPLICATION ] && echo 'Yes' || echo 'No'` \
		`[ -e /etc/systemd/system/$APPLICATION.service ] && echo 'Yes' || echo 'No'` \
		`echo "[ -e /home/deno/$APPLICATION ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash` \
		`echo "[ -e /etc/systemd/system/$APPLICATION.service ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash` \
		`jq -r ".application_list.$APPLICATION.local_port" < ~/.ksctl/ksctl.env.json` \
		`jq -r ".application_list.$APPLICATION.remote_port" < ~/.ksctl/ksctl.env.json` \
		$APPLICATION \
		$FQDN \
		`jq -r ".application_list.$APPLICATION.origin" < ~/.ksctl/ksctl.env.json`
done
echo
