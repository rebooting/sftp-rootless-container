build:
	podman build -t rebooting/sftp -f Dockerfile .
run:
	podman run --rm -p 2222:2222 -d rebooting/sftp foo:pass:::upload