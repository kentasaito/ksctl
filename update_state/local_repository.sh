sqlite3 ~/.ksctl/states.db "update applications set l_r = '`[ -e $LOCAL_DIRECTORY/$APPLICATION ] && echo 'Yes' || echo 'No'`' where application = '$APPLICATION'"
