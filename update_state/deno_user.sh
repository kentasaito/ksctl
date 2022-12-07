sqlite3 ~/.ksctl/states.db "update servers set deno_user = '`echo "[ -e /home/deno ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash`' where server = '$SERVER'"
