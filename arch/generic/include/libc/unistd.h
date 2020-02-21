#pragma once

#include <stdint.h>
#include <syscall.h>
#include <stdbool.h>

#define CONFIG_FS_MAX_FILENAME_LEN 255

typedef struct {
    char name[CONFIG_FS_MAX_FILENAME_LEN];
    bool isdir;
} listdir_t;

DEF_SYSCALL(SYSCALL_SLEEP, sleep, unsigned int, secs);
DEF_SYSCALL(SYSCALL_MSLEEP, msleep, unsigned int, msecs);
DEF_SYSCALL(SYSCALL_USLEEP, usleep, unsigned int, usecs);
DEF_SYSCALL(SYSCALL_CHDIR, chdir, const char *, path);
DEF_SYSCALL(SYSCALL_GETCWD, getcwd, char *, buf, int, buflen);
DEF_SYSCALL(SYSCALL_LISTDIR, listdir, char *, path, uint32_t, offset, listdir_t *, dirs, int, dirslen);
