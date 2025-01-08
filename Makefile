## Usage
##
## make run && make init && make install && make user && make sshd
##
## Specify the following options from command-line as needed
##

-include .config

ifneq ($(HAVE_DOT_CONFIG),y)
all:
	$(error Please configure this project first (e.g. "make menuconfig"))
else # ifneq ($(HAVE_DOT_CONFIG),y)

CONFIG_MK ?= Makefile.cfg
include $(CONFIG_MK)

TTY_OPTS    := -it
DETACH_OPTS := -d
NET_OPTS    := #--network=host
VOL_OPTS    := $(addprefix -v , $(VOLS))
PORT_OPTS   := $(addprefix -p , $(PORTS))
EXPOSE_OPTS := $(addprefix --expose , $(EXPOSES))

override RUN_OPTS += $(TTY_OPTS) $(DETACH_OPTS) $(NET_OPTS) $(VOL_OPTS) $(PORT_OPTS) $(EXPOSE_OPTS)

run:
	docker run $(RUN_OPTS) --name $(NAME) $(IMAGE):$(TAG)

start:
	docker start $(NAME)

stop:
	docker stop $(NAME)

rm:
	docker rm $(NAME)

exec:
	docker exec $(TTY_OPTS) $(NAME) $(PROG)

init:
	docker exec $(NAME) chown -R root:root /etc/pacman.d/
	docker exec $(NAME) pacman-key --init
	docker exec $(NAME) pacman-key --populate
	docker exec $(NAME) pacman -Sy --noconfirm archlinux-keyring
	docker exec $(NAME) pacman -Sy --noconfirm archlinuxcn-keyring

install:
	docker exec $(NAME) pacman -Syu --noconfirm $(PKGS) --overwrite "/etc/ssh/*"

user:
	$(eval PASSWD := $(shell cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 18))
	@echo "$(USER):$(PASSWD)" | tee /dev/stderr
	docker exec $(NAME) useradd $(USER) -m -G wheel -s $(SH) --password $(shell perl -e "print crypt(\"$(PASSWD)\","password")")

passwd:
	$(eval PASSWD := $(shell cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 18))
	@echo "$(USER):$(PASSWD)" | tee /dev/stderr |\
	docker exec -i $(NAME) chpasswd

sshdgenkeys: ./ssh/ssh_host_ecdsa_key ./ssh/ssh_host_ed25519_key ./ssh/ssh_host_rsa_key
./ssh/ssh_host_ecdsa_key ./ssh/ssh_host_ed25519_key ./ssh/ssh_host_rsa_key:
	docker exec $(NAME) bash -c "/usr/bin/ssh-keygen -A"

sshd: sshdgenkeys
	docker exec $(DETACH_OPTS) $(NAME) /usr/bin/sshd -D

endif # ifneq ($(HAVE_DOT_CONFIG),y)

export CONFIG_=
include kconfig/config.mk
