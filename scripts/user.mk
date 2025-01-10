ifeq ($(SUDO_ALLOW),y)

sudo:
ifeq ($(SUDO_NOPASSWD),y)
	docker exec $(NAME) sh -c 'echo "$(USER) ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers.d/90_$(USER)'
else
	docker exec $(NAME) sh -c 'echo "$(USER) ALL=(ALL) ALL" | tee -a /etc/sudoers.d/90_$(USER)'
endif

user: sudo

endif

user:
	$(eval PASSWD := $(shell cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 18))
	@echo "$(USER):$(PASSWD)" | tee /dev/stderr
	docker exec $(NAME) useradd $(USER) $(CREATE_GROUP_OPT) $(CREATE_HOME_OPT) -s $(SH) --password $(shell perl -e "print crypt(\"$(PASSWD)\","password")")

passwd:
	$(eval PASSWD := $(shell cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 18))
	@echo "$(USER):$(PASSWD)" | tee /dev/stderr |\
	docker exec -i $(NAME) chpasswd
