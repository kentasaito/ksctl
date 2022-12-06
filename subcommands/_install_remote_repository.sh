#!/bin/bash
git config --global init.defaultBranch master
git init --bare ~/$APPLICATION.git
cat << 'EOF' > ~/$APPLICATION.git/hooks/post-receive
#!/bin/sh
if [ -e ~/$APPLICATION ]
then
	cd ~/$APPLICATION
	git --git-dir=.git pull
else
	cd ~
	git clone ~/$APPLICATION.git
fi
EOF
chmod 775 ~/$APPLICATION.git/hooks/post-receive
