sqlite3 ~/.ksctl/states.db "update applications set r_r = '`echo "[ -e /home/deno/$APPLICATION ] && echo 'Yes' || echo 'No'" | ssh root@$SERVER bash`' where application = '$APPLICATION'"
