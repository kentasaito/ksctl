#!/bin/bash
if [ -e ~/.ksctl/states.db ]
then
	rm ~/.ksctl/states.db
fi

sqlite3 ~/.ksctl/states.db 'create table local_repositories (local_repository primary key)'
for LOCAL_DIRECTORY in `jq -r '.local_directory_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	sqlite3 ~/.ksctl/states.db "insert into local_repositories (local_repository) values ('$LOCAL_DIRECTORY')"
done

sqlite3 ~/.ksctl/states.db 'create table servers (server primary key, local_repository)'
for SERVER in `jq -r '.server_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into servers (server, local_repository) values ('$SERVER', '$LOCAL_DIRECTORY')"
done

sqlite3 ~/.ksctl/states.db 'create table fqdns (fqdn primary key, server)'
for FQDN in `jq -r '.fqdn_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into fqdns (fqdn, server) values ('$FQDN', '$SERVER')"
done

sqlite3 ~/.ksctl/states.db 'create table applications (application primary key, fqdn)'
for APPLICATION in `jq -r '.application_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	FQDN=`jq -r ".application_list.\"$APPLICATION\".fqdn" < ~/.ksctl/ksctl.env.json`
	sqlite3 ~/.ksctl/states.db "insert into applications (application, fqdn) values ('$APPLICATION', '$FQDN')"
done
