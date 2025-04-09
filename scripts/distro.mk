include scripts/arch.mk
include scripts/debian.mk
include scripts/ubuntu.mk

install:
	docker exec $(NAME) bash -c '$(call unquote,$(PM_INSTALL)) $(call unquote,$(PKGS))'
