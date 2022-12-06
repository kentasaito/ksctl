#!/bin/bash

if [ -z "$1" ]
then
	echo 'no application specified'
	exit 1
fi
export APPLICATION=$1
export LOCAL_PORT=`jq -r ".application_list.\"$APPLICATION\".local_port" < ~/.ksctl/ksctl.env.json`
export REMOTE_PORT=`jq -r ".application_list.\"$APPLICATION\".remote_port" < ~/.ksctl/ksctl.env.json`
export FQDN=`jq -r ".application_list.$APPLICATION.fqdn" < ~/.ksctl/ksctl.env.json`
export SERVER=`jq -r ".fqdn_list.\"$FQDN\".server" < ~/.ksctl/ksctl.env.json`
export LOCAL_DIRECTORY=`jq -r ".server_list.\"$SERVER\".local_directory" < ~/.ksctl/ksctl.env.json`

cat << EOF | sudo tee /etc/systemd/system/$APPLICATION.service
[Service]
User=$USER
WorkingDirectory=$LOCAL_DIRECTORY/$APPLICATION
Environment=FQDN=$FQDN
Environment=REMOTE_PORT=$REMOTE_PORT
Environment=LOCAL_PORT=$LOCAL_PORT
ExecStart=/home/$USER/.deno/bin/deno run --watch --allow-env --allow-read --allow-write --allow-net server/main.ts
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable $APPLICATION.service
sudo systemctl start $APPLICATION.service
