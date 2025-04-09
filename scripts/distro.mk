include scripts/arch.mk

install:
	docker exec $(NAME) bash -c '$(call unquote,$(PM_INSTALL)) $(call unquote,$(PKGS))'
