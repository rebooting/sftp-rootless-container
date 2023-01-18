.PHONY: build run logs
build: clean
	podman build -t rebooting/sftp -f Dockerfile .
build-ecs: clean
	podman build -t rebooting/sftp -f Dockerfile-ecs .
run:
	podman run --rm --name sftp -v ./files/users.conf:/etc/sftp/users.conf:ro -p 2222:2222 -d rebooting/sftp 
log:
	podman logs -f sftp

kill:
	podman kill sftp

shell:
	podman exec -it sftp bash
clean:
	podman system prune -f

gen_users:
	cd files && python3 gen_dummy_users.py 
	echo "module(load=\"imuxsock\")" > files/sftplog.conf
	cat files/socket.txt >> files/sftplog.conf 
	cat files/end_rsync.txt >> files/sftplog.conf 

key:
	ssh-keygen -b 2048 -t rsa -f keys/sshkey -q -N ""

connect:
	sftp -P 2222  -o UserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i keys/sshkey  user1@localhost

connect-others:
	sftp -P 2222  -o UserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i keys/sshkey  someone@localhost

up:
	podman-compose up -d
down:
	podman-compose down
rm:
	podman-compose rm
compose-log-sftp:
	podman logs -f sftp-rootless-container_sftpproxy_1 
compose-shell-sftp:
	podman exec -it sftp-rootless-container_sftpproxy_1 bash
tag_upload:
	podman podman tag localhost/rebooting/sftp:latest docker.io/rebooting/sftp
	podman push docker.io/rebooting/sftp:latest 
