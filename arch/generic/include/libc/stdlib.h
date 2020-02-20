#pragma once

#include <syscall.h>
#include <stdint.h>

DEF_SYSCALL(SYSCALL_EXIT, exit, int, status);
DEF_SYSCALL(SYSCALL_YIELD, yield);
DEF_SYSCALL(SYSCALL_GETPID, getpid);
DEF_SYSCALL(SYSCALL_SET_PRIORITY, set_priority, uint8_t, priority);
DEF_SYSCALL(SYSCALL_SET_PROCESS_NAME, set_process_name, char *, name);

/**
 * This is just for debugging purposes. A production kernel will not have
 * this syscall enabled, hopefully.
 */
DEF_SYSCALL(SYSCALL_BACKDOOR, backdoor, char *, cmd, void *, param);


