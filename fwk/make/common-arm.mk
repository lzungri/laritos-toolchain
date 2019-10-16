ifndef SUBARCH
  $(warning SUBARCH env variable not set (using armv7-a by defaul). Supported sub=architectures: armv7-a, armv8-a)
  SUBARCH := armv7-a
endif

CFLAGS += -marm
CFLAGS += -march=$(SUBARCH)
CFLAGS += -Wa,-march=$(SUBARCH)
CFLAGS += -mlittle-endian
CFLAGS += -msoft-float
CFLAGS += -Uarm
