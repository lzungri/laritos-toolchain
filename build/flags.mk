# Target OS
CFLAGS += -D__LARITOS__

# Warning/error (mostly taken from laritOS makefile)
CFLAGS += -Wall
CFLAGS += -Wundef
CFLAGS += -Werror=strict-prototypes
CFLAGS += -Wno-trigraphs
CFLAGS += -fno-strict-aliasing
CFLAGS += -fno-common
CFLAGS += -fno-PIE
CFLAGS += -Werror=implicit-function-declaration
CFLAGS += -Werror=implicit-int
CFLAGS += -Wno-format-security
CFLAGS += -fno-delete-null-pointer-checks
CFLAGS += -Wno-frame-address
CFLAGS += -Wno-format-truncation
CFLAGS += -Wno-format-overflow --param=allow-store-data-races=0
CFLAGS += -Wno-unused-but-set-variable
CFLAGS += -Wno-unused-const-variable
CFLAGS += -fno-var-tracking-assignments
CFLAGS += -Wno-pointer-sign
CFLAGS += -Wno-stringop-truncation
CFLAGS += -fno-strict-overflow
CFLAGS += -fno-merge-all-constants
CFLAGS += -fmerge-constants
CFLAGS += -fno-stack-check
CFLAGS += -fconserve-stack
CFLAGS += -ffunction-sections
CFLAGS += -fdata-sections
CFLAGS += -Werror=date-time
CFLAGS += -Werror=incompatible-pointer-types
CFLAGS += -Werror=designated-init
CFLAGS += -Wno-packed-not-aligned
CFLAGS += -fvisibility=hidden
CFLAGS += -fno-unwind-tables
# -ffreestanding: Assert that compilation targets a freestanding environment.  This implies -fno-builtin.
# 		A freestanding environment is one in which the standard library may not exist, and program startup may
# 		not necessarily be at "main".  The most obvious example is an OS kernel.  This is equivalent to -fno-hosted.
# By setting this flag, $(CROSS_COMPILE)gcc will try to use its own set of custom headers
CFLAGS += -ffreestanding

# laritOS uses a 4-byte wchar by default
CFLAGS += -fno-short-wchar

# Standard
CFLAGS += -std=gnu11

# System headers
CFLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

# Include paths
CFLAGS += -I$(ROOT_ARCH)/include/libc
CFLAGS += -I$(ROOT_ARCH)/include
CFLAGS += -I$(ROOT_GENERIC_ARCH)/include/libc
CFLAGS += -I$(ROOT_GENERIC_ARCH)/include
CFLAGS += -I.

# Enable position independent code
CFLAGS += -fpic
# Use pc-relative addressing for referencing symbols in the data segment
CFLAGS += -mno-pic-data-is-text-relative
CFLAGS += -msingle-pic-base
CFLAGS += -mpic-register=r9

# Optimization
#CFLAGS += -Os

# Benchmarking
ifdef STACK_USAGE
CFLAGS += -fstack-usage
endif

# Debugging
#CFLAGS += -g

# Generate dependency files (useful for rebuilding on header change)
CFLAGS_DEPS = -MT $@ -MMD -MP -MF $(OUTPUT_DEPS)/$*.d


# Linker flags
APP_MEMMAP := $(ROOT_ARCH)/ld/app_memmap.lds
LDFLAGS += -Map $(OUTPUT)/$(APP).elf.map
LDFLAGS += -nostartfiles
LDFLAGS += -nostdlib
LDFLAGS += --emit-relocs
# We need relocations to be able to load the program at a different address
LDFLAGS += --gc-sections
#LDFLAGS += -print-gc-sections
# Keep symbols with default visibility
LDFLAGS += --gc-keep-exported
LDFLAGS += -Bstatic
LDFLAGS += -T $(APP_MEMMAP)