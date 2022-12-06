# Download getssl and execute
sudo -u deno -i /home/deno/getssl -c $FQDN
cat << 'EOF' > /home/deno/.getssl/getssl.cfg
CA="https://acme-v02.api.letsencrypt.org"
ACCOUNT_KEY_LENGTH=4096
ACCOUNT_KEY="/home/deno/.getssl/account.key"
PRIVATE_KEY_ALG="rsa"
RENEW_ALLOW="30"
SERVER_TYPE="https"
CHECK_REMOTE="true"
EOF
cat << 'EOF' > /home/deno/.getssl/$FQDN/getssl.cfg
ACL=('/home/deno/ks_ssl_bot/.well-known/acme-challenge')
EOF
sudo -u deno -i /home/deno/getssl $FQDN

# Create a crontab
sudo -u deno bash -c '(crontab -l; echo "17 3 * * * /home/deno/getssl -u -a -q") | crontab -'
