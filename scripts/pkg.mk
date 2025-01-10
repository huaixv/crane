# All packages
ALL_PKGS := $(shell cat Kconfig | grep -o 'config PKG_USE_[A-Za-z0-9_]*' | awk '{print $$2}' | sed 's/PKG_USE_//g')

# Enabled Packgaes
PKGS :=
$(foreach pkg,$(ALL_PKGS),$(if $(PKG_USE_$(pkg)),$(eval PKGS += $(PKG_$(pkg)))))

include scripts/sshd.mk
