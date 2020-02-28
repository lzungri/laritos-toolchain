#pragma once

#include <syscall.h>

// aka ctrl-c
#define CHAR_END_OF_TEXT (0x3)
#define CHAR_DELETE (0x7f)
#define CHAR_EOF (-1)

#define CURSOR_LEFT "\033[1D"

DEF_SYSCALL(SYSCALL_PUTS, puts, const char *, s);
DEF_SYSCALL(SYSCALL_READLINE, readline, char *, buf, int, buflen);
DEF_SYSCALL(SYSCALL_GETC, getc);

int readline_and_prompt(char *buf, int buflen);

