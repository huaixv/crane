VOL_OPTS :=

ifeq ($(VOLUME_HOME),y)
$(shell mkdir -p $(VOLUME_HOME_TO))
VOL_OPTS += --mount type=bind,dst=/home,src=$(abspath $(call unquote,$(VOLUME_HOME_TO)))
endif

ifeq ($(VOLUME_ETC),y)
$(shell mkdir -p $(VOLUME_ETC_TO))
VOL_OPTS += --mount type=bind,dst=/etc,src=$(abspath $(call unquote,$(VOLUME_ETC_TO)))
endif

ifeq ($(VOLUME_VAR),y)
$(shell mkdir -p $(VOLUME_VAR_TO))
VOL_OPTS += --mount type=bind,dst=/var,src=$(abspath $(call unquote,$(VOLUME_VAR_TO)))
endif

ifeq ($(VOLUME_SRV),y)
$(shell mkdir -p $(VOLUME_SRV_TO))
VOL_OPTS += --mount type=bind,dst=/srv,src=$(abspath $(call unquote,$(VOLUME_SRV_TO)))
endif

ifeq ($(VOLUME_DEV),y)
VOL_OPTS += --mount type=bind,dst=/dev,src=$(abspath $(call unquote,$(VOLUME_DEV_TO)))
endif

ifeq ($(VOLUME_SYS),y)
VOL_OPTS += --mount type=bind,dst=/sys,src=$(abspath $(call unquote,$(VOLUME_SYS_TO)))
endif

ifneq ($(VOLUME_EXTRA),)
VOL_OPTS += $(addprefix --volume ,$(call unquote,$(VOLUME_EXTRA)))
endif

RUN_OPTS += $(VOL_OPTS)
