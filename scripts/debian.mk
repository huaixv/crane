ifeq ($(DISTRO_debian),y)

debian_setup:
ifeq ($(COPY_APT_SOURCES_LIST),y)
	docker cp ./etc/apt/sources.list $(NAME):/etc/apt/sources.list
	docker exec $(NAME) apt update
	docker exec $(NAME) apt install -y apt-transport-https ca-certificates
endif

install: debian_setup

endif
