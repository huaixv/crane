ifeq ($(DISTRO_ubuntu),y)

ubuntu_setup:
ifeq ($(COPY_APT_SOURCES_LIST),y)
ifeq ($(TAG_focal),y)
	docker cp ./etc/apt/sources.list.focal $(NAME):/etc/apt/sources.list
endif
ifeq ($(TAG_jammy),y)
	docker cp ./etc/apt/sources.list.jammy $(NAME):/etc/apt/sources.list
endif
ifeq ($(TAG_noble),y)
	docker cp ./etc/apt/sources.list.noble $(NAME):/etc/apt/sources.list
	# docker cp ./etc/apt/sources.list.d/ubuntu.sources $(NAME):/etc/apt/sources.list.d/ubuntu.sources
endif
	docker exec $(NAME) apt update
	docker exec $(NAME) apt install -y ca-certificates 
	docker exec $(NAME) update-ca-certificates

endif


install: ubuntu_setup

endif