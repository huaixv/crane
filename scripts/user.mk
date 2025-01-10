ifeq ($(SUDO_ALLOW),y)

sudo:
ifeq ($(SUDO_NOPASSWD),y)
	docker exec $(NAME) sh -c 'echo "$(USER) ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers.d/90_$(USER)'
else
	docker exec $(NAME) sh -c 'echo "$(USER) ALL=(ALL) ALL" | tee -a /etc/sudoers.d/90_$(USER)'
endif

user: sudo

endif
