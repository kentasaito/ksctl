sqlite3 ~/.ksctl/states.db "update applications set l_d = '`[ -e /etc/systemd/system/$APPLICATION.service ] && echo 'Yes' || echo 'No'`' where application = '$APPLICATION'"
