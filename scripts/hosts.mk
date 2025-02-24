HOSTS_OPTS :=

ifneq ($(HOSTS_EXTRA),)
HOSTS_OPTS += $(addprefix --add-host ,$(call unquote,$(HOSTS_EXTRA)))
endif

RUN_OPTS += $(HOSTS_OPTS)
