_ksctl_completion() {
  _get_comp_words_by_ref -n : cur prev
	case ${COMP_CWORD} in
		1)
		  opts="\
				show_states take_snapshot \
				show_local_directory_list show_server_list show_fqdn_list show_application_list \
				install_remote_daemon uninstall_remote_daemon install_remote_repository uninstall_remote_repository \
				install_local_daemon uninstall_local_daemon install_local_repository uninstall_local_repository \
				install_ssl_certificate uninstall_ssl_certificate \
				install_ssl_bot uninstall_ssl_bot install_deno_user uninstall_deno_user
			"
		  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
			;;
		2)
			case $prev in
				install_remote_daemon | uninstall_remote_daemon | install_remote_repository | uninstall_remote_repository | \
				install_local_daemon | uninstall_local_daemon | install_local_repository | uninstall_local_repository )
				  opts=`jq -r '.application_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
				  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
					;;
				install_ssl_certificate | uninstall_ssl_certificate )
				  opts=`jq -r '.fqdn_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
				  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
					;;
				install_ssl_bot | uninstall_ssl_bot | install_deno_user | uninstall_deno_user )
				  opts=`jq -r '.server_list | keys | .[]' < ~/.ksctl/ksctl.env.json`
				  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
					;;
			esac
			;;
	esac
}

complete -F _ksctl_completion ksctl
