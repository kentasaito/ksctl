#!/bin/bash
cat << 'EOF' > /etc/systemd/system/$APPLICATION.service
[Service]
User=deno
WorkingDirectory=/home/deno/$APPLICATION
Environment=FQDN=$FQDN
Environment=REMOTE_PORT=$REMOTE_PORT
Environment=LOCAL_PORT=$LOCAL_PORT
Environment=USE_TLS=1
AmbientCapabilities=CAP_NET_BIND_SERVICE
ExecStart=/home/deno/.deno/bin/deno run --watch --allow-env --allow-read --allow-write --allow-net server/main.ts
[Install]
WantedBy=multi-user.target
EOF
systemctl enable $APPLICATION.service
systemctl start $APPLICATION.service
