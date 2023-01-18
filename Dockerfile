FROM debian:bullseye

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server sudo rsyslog&& \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY files/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

COPY files/sftplog.conf /etc/rsyslog.d/sftplog.conf
COPY files/sftp_forwarder.sh /
RUN chmod +x sftp_forwarder.sh 

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
