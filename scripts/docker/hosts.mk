HOSTS_OPTS :=

ifeq ($(HOSTS_LAB_MIRRORS),y)
HOSTS_OPTS += --add-host mirrors.lab.loongson.cn:172.17.103.58
endif

ifneq ($(HOSTS_EXTRA),)
HOSTS_OPTS += $(addprefix --add-host ,$(call unquote,$(HOSTS_EXTRA)))
endif

RUN_OPTS += $(HOSTS_OPTS)
