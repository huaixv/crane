VOL_OPTS :=

VOL_BIND_OPT := type=volume,volume-driver=local,volume-opt=type=none,volume-opt=o=bind

ifeq ($(VOLUME_HOME),y)
$(shell mkdir -p $(VOLUME_HOME_TO))
VOL_OPTS += --mount $(VOL_BIND_OPT),dst=/home,volume-opt=device=$(abspath $(VOLUME_HOME_TO))
endif

ifeq ($(VOLUME_ETC),y)
$(shell mkdir -p $(VOLUME_ETC_TO))
VOL_OPTS += --mount $(VOL_BIND_OPT),dst=/etc,volume-opt=device=$(abspath $(VOLUME_ETC_TO))
endif

ifeq ($(VOLUME_VAR),y)
$(shell mkdir -p $(VOLUME_VAR_TO))
VOL_OPTS += --mount $(VOL_BIND_OPT),dst=/var,volume-opt=device=$(abspath $(VOLUME_VAR_TO))
endif

ifeq ($(VOLUME_SRV),y)
$(shell mkdir -p $(VOLUME_SRV_TO))
VOL_OPTS += --mount $(VOL_BIND_OPT),dst=/srv,volume-opt=device=$(abspath $(VOLUME_SRV_TO))
endif

ifneq ($(VOLUME_EXTRA),)
VOL_OPTS += $(addprefix --volume ,$(call unquote,$(VOLUME_EXTRA)))
endif

RUN_OPTS += $(VOL_OPTS)
