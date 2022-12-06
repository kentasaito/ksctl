# install getssl
sudo -u deno -i bash -c 'curl --silent https://raw.githubusercontent.com/srvrco/getssl/v2.47/getssl > getssl; chmod 700 getssl'

# Create ks_ssl_bot process that runs on systemd
mkdir /home/deno/ks_ssl_bot
cat << 'EOF' > /etc/systemd/system/ks_ssl_bot.service
[Service]
User=deno
WorkingDirectory=/home/deno/ks_ssl_bot
AmbientCapabilities=CAP_NET_BIND_SERVICE
ExecStart=/home/deno/.deno/bin/deno run --watch --allow-read --allow-net main.ts
[Install]
WantedBy=multi-user.target
EOF
cat << 'EOF' > /home/deno/ks_ssl_bot/main.ts
import { serve } from 'https://deno.land/std@0.166.0/http/server.ts';
function handler(request) {
	const url = new URL(request.url);
	if (url.pathname.startsWith('/.well-known/acme-challenge/')) {
		try {
			return new Response(Deno.readFileSync('.' + url.pathname));
		} catch (error) {
			return new Response('Not Found', {
				status: 404,
			});
		}
	} else {
		return Response.redirect(request.url.replace(/^http:/, 'https:'));
	}
}
serve(handler, {
	port: 80,
});
EOF
chown -R deno:deno /home/deno/ks_ssl_bot
systemctl enable ks_ssl_bot.service
systemctl start ks_ssl_bot.service
