include scripts/arch.mk

install:
	docker exec $(NAME) $(call unquote,$(PM_INSTALL)) $(PKGS)
