CAP_OPTS := 

ifeq ($(CAP_SYS_ADMIN),y)
CAP_OPTS += --cap-add=SYS_ADMIN
endif

ifeq ($(CAP_PERFMON), y)
CAP_OPTS += --cap-add=PERFMON
endif

ifneq ($(CAP_EXTRA),)
CAP_OPTS += $(addprefix --cap-add=,$(call unquote,$(CAP_EXTRA)))
endif

ifeq ($(CAP_PRIVILEGED),y)
CAP_OPTS += --privileged
endif

RUN_OPTS += $(CAP_OPTS)
