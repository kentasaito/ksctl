sqlite3 ~/.ksctl/states.db "update fqdns set ssl_certificate = '`echo "[ -e /home/deno/.getssl/$FQDN/$FQDN.crt ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash`' where fqdn = '$FQDN'"
