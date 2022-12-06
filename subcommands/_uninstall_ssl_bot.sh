crontab -u deno -r
systemctl stop ks_ssl_bot.service
systemctl disable ks_ssl_bot.service
rm /etc/systemd/system/ks_ssl_bot.service
rm -r /home/deno/ks_ssl_bot
rm -r /home/deno/.getssl
rm /home/deno/getssl
