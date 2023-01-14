#!/bin/bash
#  Generic shell wrapper that performs an operation

OPERATION=/usr/bin/sftp
args=("$@")
#the final arg should contain a hostname of the form [user@]host[:path]
# exec $OPERATION -s "/usr/bin/sudo /usr/libexec/openssh/sftp-server" 
# exec $OPERATION -o UserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -P 4022 -i keys/sshkey  lo@192.168.201.21
ssh-keygen -f $HOME/.ssh/id_rsa -q -N ""
exec /usr/bin/ssh -o UserKnownHostsFile=/dev/null -v -oStrictHostKeyChecking=no -p 4022  lo@192.168.201.21 -s sftp 2>/tmp/err.txt