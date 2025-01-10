## Usage
##
## make run && make install && make user && make sshd
##
## Specify the following options from command-line as needed
##

-include .config

ifneq ($(HAVE_DOT_CONFIG),y)
all:
	$(error Please configure this project first (e.g. "make menuconfig"))
else # ifneq ($(HAVE_DOT_CONFIG),y)

all: run

include scripts/util.mk

include scripts/distro.mk
include scripts/docker.mk
include scripts/pkg.mk
include scripts/user.mk

sshd:
	docker exec $(NAME) /usr/bin/ssh-keygen -A
	docker exec $(EXEC_BG_OPTS) $(NAME) /usr/bin/sshd -D

endif # ifneq ($(HAVE_DOT_CONFIG),y)

export CONFIG_=
include kconfig/config.mk
