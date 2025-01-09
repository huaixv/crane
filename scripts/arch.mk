ifeq ($(DISTRO_archlinux),y)

arch_setup:
	docker exec $(NAME) pacman-key --init
ifeq ($(COPY_PACMAN_MIRRORLIST),y)
	docker cp ./etc/pacman.d/mirrorlist $(NAME):/etc/pacman.d/mirrorlist
endif
ifeq ($(COPY_PACMAN_CONF),y)
	docker cp ./etc/pacman.conf $(NAME):/etc/pacman.conf
endif
	docker exec $(NAME) pacman -Syu --noconfirm archlinux-keyring
ifeq ($(COPY_PACMAN_CONF),y)
	docker exec $(NAME) pacman -Syu --noconfirm archlinuxcn-keyring
endif

install: arch_setup

endif
