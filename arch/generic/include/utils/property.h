#pragma once

#include <syscall.h>
#include <syscall-no.h>

#define PROPERTY_ID_MAX_LEN 32
#define PROPERTY_VALUE_MAX_LEN 128

DEF_SYSCALL(SYSCALL_GET_PROPERTY, get_property, char *, id, void *, buf);

