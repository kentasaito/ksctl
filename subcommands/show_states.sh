#!/bin/bash
echo '= Local Directories ='
echo -e '.headers on\n.mode column\nselect * from local_directories' | sqlite3 ~/.ksctl/states.db 
echo
echo
echo '= Servers ='
echo -e '.headers on\n.mode column\nselect * from servers;' | sqlite3 ~/.ksctl/states.db 
echo
echo
echo '= FQDNs ='
echo -e '.headers on\n.mode column\nselect * from fqdns;' | sqlite3 ~/.ksctl/states.db 
echo
echo
echo '= Applications ='
echo -e '.headers on\n.mode column\nselect * from applications;' | sqlite3 ~/.ksctl/states.db 
echo
echo
