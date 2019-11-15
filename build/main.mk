LARITOS_TOOLCHAIN := $(abspath $(LARITOS_TOOLCHAIN))

SUP_ARCHS := $(sort $(subst $(LARITOS_TOOLCHAIN)/arch/,,$(wildcard $(LARITOS_TOOLCHAIN)/arch/*)))
ARCH := $(filter $(ARCH),$(SUP_ARCHS))
ifeq ($(ARCH),)
$(error ARCH variable not set or invalid architecture. Supported architectures: $(SUP_ARCHS))
endif

ifndef APP
# Set apps/<folder> as the app name
APP := $(shell basename $(CURDIR))
endif


# laritos-userpace root folder (build is launched from within the app directory)
ROOT_TOOLCHAIN := $(LARITOS_TOOLCHAIN)
ROOT_ARCH := $(ROOT_TOOLCHAIN)/arch/$(ARCH)
ROOT_GENERIC_ARCH := $(ROOT_TOOLCHAIN)/arch/generic

OUTPUT := bin/$(ARCH)
OUTPUT_DEPS := $(OUTPUT)/deps


# Toolchain definition
AS := $(CROSS_COMPILE)as
LD := $(CROSS_COMPILE)ld
CC := $(CROSS_COMPILE)gcc
CPP := $(CC) -E
AR := $(CROSS_COMPILE)ar
NM := $(CROSS_COMPILE)nm
STRIP := $(CROSS_COMPILE)strip
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
READELF := $(CROSS_COMPILE)readelf

# Setup compiler and linker flags
include $(ROOT_TOOLCHAIN)/build/flags.mk

# Include architecture-specific makefile
include $(ROOT_ARCH)/Makefile


VERBOSE = 0
ifeq ("$(origin V)", "command line")
  VERBOSE = $(V)
endif

ifeq ($(VERBOSE),1)
  Q =
else
  Q = @
endif


# Include application makefile. This will setup the sources to build, among other stuff
include $(CURDIR)/Makefile


# Separate sources by type
SRCS_C := $(filter %.c,$(SRCS))
SRCS_AS := $(filter %.S,$(SRCS))

# Append output folder to all objects
OBJS := $(addprefix $(OUTPUT)/, $(SRCS_C:.c=.o))
OBJS += $(addprefix $(OUTPUT)/, $(SRCS_AS:.S=.o))

# List of dependency files (generated by gcc)
DEPS := $(SRCS_C:%.c=$(OUTPUT_DEPS)/%.d)

# Targets
.PHONY: all clean printmap relocs

all: $(OUTPUT)/$(APP).elf

# Rebuild when dependencies, makefile and/or memory map change
$(OUTPUT)/%.o: %.c $(OUTPUT_DEPS)/%.d $(APP_MEMMAP) $(ROOT_TOOLCHAIN)/build/main.mk
	$(Q)echo "CC      $@"
	$(Q)mkdir -p $(dir $@)
	$(Q)mkdir -p $(OUTPUT_DEPS)/$(subst $(OUTPUT),,$(dir $@))
	$(Q)$(CC) $(CFLAGS) $(CFLAGS_DEPS) -c $< -o $@

# Rebuild when makefile and/or memory map change
$(OUTPUT)/%.o: %.S $(APP_MEMMAP) $(ROOT_TOOLCHAIN)/build/main.mk
	$(Q)echo "AS      $@"
	$(Q)mkdir -p $(dir $@)
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

# Build app elf
$(OUTPUT)/$(APP).elf: $(OBJS)
	$(Q)echo "LD      $@"
	$(Q)mkdir -p $(dir $@)
	$(Q)$(LD) $(LDFLAGS) $(OBJS) -o $@

clean:
	$(Q)echo "CLEAN  $(OUTPUT)"
	$(Q)rm -rf $(OUTPUT)

printmap: $(OUTPUT)/$(APP).elf
	$(Q)cat $<.map

relocs: $(OUTPUT)/$(APP).elf
	$(Q)$(READELF) -r $<

$(DEPS):

# Include all auto-generated dependency targets
include $(wildcard $(DEPS))