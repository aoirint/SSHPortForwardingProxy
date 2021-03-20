
build:
	docker build . -t aoirint/sshremoteserver

run:
	docker run --rm -it \
        -v "${PWD}/authorized_keys:/authorized_keys" \
        -v "${PWD}/sshd_log:/sshd_log" \
        -p "127.0.0.1:10022:22" \
        aoirint/sshremoteserver

