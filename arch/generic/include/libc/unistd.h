#pragma once

#include <stdint.h>
#include <syscall.h>
#include <stdbool.h>

#define CONFIG_FS_MAX_FILENAME_LEN 255

typedef struct {
    char name[CONFIG_FS_MAX_FILENAME_LEN];
    bool isdir;
} listdir_t;

typedef enum {
    ACCESS_MODE_EXEC = 1,
    ACCESS_MODE_WRITE = 2,
    ACCESS_MODE_READ = 4,
    ACCESS_MODE_DIR = 8,
} access_mode_t;

typedef void file_t;

DEF_SYSCALL(SYSCALL_SLEEP, sleep, unsigned int, secs);
DEF_SYSCALL(SYSCALL_MSLEEP, msleep, unsigned int, msecs);
DEF_SYSCALL(SYSCALL_USLEEP, usleep, unsigned int, usecs);
DEF_SYSCALL(SYSCALL_CHDIR, chdir, const char *, path);
DEF_SYSCALL(SYSCALL_GETCWD, getcwd, char *, buf, int, buflen);
DEF_SYSCALL(SYSCALL_LISTDIR, listdir, char *, path, uint32_t, offset, listdir_t *, dirs, int, dirslen);
DEF_SYSCALL_RET_TYPE(file_t *, SYSCALL_OPEN, open, char *, path, access_mode_t, mode);
DEF_SYSCALL(SYSCALL_CLOSE, close, file_t *, file);
DEF_SYSCALL(SYSCALL_READ, read, file_t *, file, void *, buf, int, buflen);
DEF_SYSCALL(SYSCALL_WRITE, write, file_t *, file, void *, buf, int, buflen);
