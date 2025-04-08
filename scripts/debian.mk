ifeq ($(DISTRO_debian),y)

debian_setup:
ifeq ($(COPY_APT_SOURCES_LIST),y)
ifeq ($(TAG_bookworm),y)
	docker cp ./etc/apt/sources.list.bookworm $(NAME):/etc/apt/sources.list
endif
ifeq ($(TAG_bullseye),y)
	docker cp ./etc/apt/sources.list.bullseye $(NAME):/etc/apt/sources.list
endif
ifeq ($(TAG_sid),y)
	docker cp ./etc/apt/sources.list.sid $(NAME):/etc/apt/sources.list
endif
	docker exec $(NAME) apt update
	docker exec $(NAME) apt install -y apt-transport-https ca-certificates
endif


install: debian_setup

endif
