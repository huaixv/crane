sshd:
	docker exec $(NAME) /usr/bin/ssh-keygen -A
	docker exec $(EXEC_BG_OPTS) $(NAME) /usr/bin/sshd -D
