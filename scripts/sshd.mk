sshd: start
ifeq ($(or $(DISTRO_debian),$(DISTRO_ubuntu)),y)
	docker exec $(NAME) mkdir -p /run/sshd 
	docker exec $(NAME) chmod 755 /run/sshd
endif
	docker exec $(NAME) /usr/bin/ssh-keygen -A
	docker exec $(EXEC_BG_OPTS) $(NAME) /usr/sbin/sshd -D
