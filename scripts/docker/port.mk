PORT_OPTS := 

ifeq ($(PORT_22),y)
ifneq ($(PORT_22_TO),)
PORT_OPTS += -p $(PORT_22_TO):22
else
PORT_OPTS += -p 22
endif
endif

ifeq ($(PORT_80),y)
ifneq ($(PORT_80_TO),)
PORT_OPTS += -p $(PORT_80_TO):80
else
PORT_OPTS += -p 80
endif
endif

ifeq ($(PORT_443),y)
ifneq ($(PORT_443_TO),)
PORT_OPTS += -p $(PORT_443_TO):443
else
PORT_OPTS += -p 443
endif
endif

ifneq ($(PORT_EXTRA),)
PORT_OPTS += $(addprefix -p ,$(call unquote,$(PORT_EXTRA)))
endif

RUN_OPTS += $(PORT_OPTS)
