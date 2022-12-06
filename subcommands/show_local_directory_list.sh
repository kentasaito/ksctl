#!/bin/bash
printf '%-28.28s\n' \
	LOCAL_DIRECTORY

for LOCAL_DIRECTORY in `jq -r '.local_directory_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
do
	printf '%-80.80s\n' \
		$LOCAL_DIRECTORY
done
echo
