#!/bin/bash
#  Generic shell wrapper that performs an operation
OPERATION=/usr/bin/sftp
args=("$@")
#the final arg should contain a hostname of the form [user@]host[:path]
# exec $OPERATION -s "/usr/bin/sudo /usr/libexec/openssh/sftp-server" 
# exec $OPERATION -o UserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -P 4022 -i keys/sshkey  lo@192.168.201.21
ID_RSA=$HOME/.ssh/id_rsa
# echo $HOME >> /tmp/home
if [ ! -f "$ID_RSA" ]; then
    ssh-keygen -f $HOME/.ssh/id_rsa -q -N ""
fi
# echo $USER>>/tmp/output

exec /usr/bin/ssh -o UserKnownHostsFile=/dev/null -v -oStrictHostKeyChecking=no -p 4022  $USER@localhost -s sftp 2>/tmp/`/usr/bin/whoami`.txt
# exec /usr/bin/sftp -o UserKnownHostsFile=/dev/null -v -oStrictHostKeyChecking=no -P 4022 1001@jsftp 2>/tmp/err.txt
