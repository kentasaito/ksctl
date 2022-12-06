# Create deno user and install Deno
useradd deno -m -s /bin/bash
rm /home/deno/.*
apt install unzip
sudo -u deno bash -c 'curl -fsSL https://deno.land/x/install/install.sh | sh'

# Copy root's SSH authorized keys to deno user
mkdir /home/deno/.ssh
cp -a /root/.ssh/authorized_keys /home/deno/.ssh/
chown -R deno:deno /home/deno/.ssh
