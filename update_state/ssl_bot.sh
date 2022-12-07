sqlite3 ~/.ksctl/states.db "update servers set ssl_bot = '`echo "[ -e /home/deno/ks_ssl_bot ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash`' where server = '$SERVER'"
