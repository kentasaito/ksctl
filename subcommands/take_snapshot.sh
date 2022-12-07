#!/bin/bash
if [ -e ~/.ksctl/states.db ]
then
	rm ~/.ksctl/states.db
fi

sqlite3 ~/.ksctl/states.db 'create table local_directories (local_repository primary key)'
for LOCAL_DIRECTORY in `jq -r '.local_directory_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	sqlite3 ~/.ksctl/states.db "insert into local_directories (local_repository) values ('$LOCAL_DIRECTORY')"
done

sqlite3 ~/.ksctl/states.db 'create table servers (deno_user, ssl_bot, server primary key, local_repository)'
for SERVER in `jq -r '.server_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into servers (server, local_repository) values ('$SERVER', '$LOCAL_DIRECTORY')"
	export SERVER
	envsubst < `dirname $0`/../update_state/deno_user.sh | bash
	envsubst < `dirname $0`/../update_state/ssl_bot.sh | bash
done

sqlite3 ~/.ksctl/states.db 'create table fqdns (ssl_certificate, fqdn primary key, server)'
for FQDN in `jq -r '.fqdn_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into fqdns (fqdn, server) values ('$FQDN', '$SERVER')"
	export FQDN
	export SERVER
	envsubst < `dirname $0`/../update_state/fqdns.sh | bash
done

sqlite3 ~/.ksctl/states.db 'create table applications (l_r, l_d, r_r, r_d, l_port, r_port, application primary key, fqdn)'
for APPLICATION in `jq -r '.application_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	FQDN=`jq -r ".application_list.\"$APPLICATION\".fqdn" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into applications (application, fqdn) values ('$APPLICATION', '$FQDN')"
	sqlite3 ~/.ksctl/states.db "update applications set l_port = '`jq -r ".application_list.$APPLICATION.local_port" < ~/.ksctl/ksctl.env.json`' where application = '$APPLICATION'"
	sqlite3 ~/.ksctl/states.db "update applications set r_port = '`jq -r ".application_list.$APPLICATION.remote_port" < ~/.ksctl/ksctl.env.json`' where application = '$APPLICATION'"
	export APPLICATION
	export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
	export LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`
	envsubst < `dirname $0`/../update_state/local_repository.sh | bash
	envsubst < `dirname $0`/../update_state/local_daemon.sh | bash
	envsubst < `dirname $0`/../update_state/remote_repository.sh | bash
	envsubst < `dirname $0`/../update_state/remote_deamon.sh | bash
done

ksctl show_states
