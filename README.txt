ksctl
A manager for Deno projects

Install
	git clone https://github.com/kentasaito/ksctl.git ~/.ksctl
	echo 'export PATH="~/.ksctl/bin:$PATH"' >> ~/.bashrc
	sudo cp ~/.ksctl/_ksctl_completion.sh /usr/share/bash-completion/completions/ksctl
	cp ~/.ksctl/ksctl.env.json.example ~/.ksctl/ksctl.env.json

Entity Relationship
	Edit ksctl.env.json and run 'ksctl take_snapshot' before use
	- Your machine has one or more local directories
	- Local directory has one or more Servers
	- Server has one or more FQDNs
	- FQDN has one or more application

Usage:
	ksctl [Subcommand] [(server|fqdn|application)]

Subcommands:
	show_states
		show local directories, servers, FQDNs and applications with states

	(install|uninstall)_deno_user [server]
		Install / Uninstall deno user on the server

	(install|uninstall)_ssl_bot [server]
		Install / Uninstall SSL bot on the server

	(install|uninstall)_ssl_certificate [fqdn]
		Install / Uninstall SSL certificate on the server

	(install|uninstall)_local_repository [application]
		Install / Uninstall local repository on your machine

	(install|uninstall)_local_daemon [application]
		Install / Uninstall daemon on your machine

	(install|uninstall)_remote_repository [application]
		Install / Uninstall remote repositiory on the server

	(install|uninstall)_remote_daemon [application]
		Install / Uninstall daemon on the server
