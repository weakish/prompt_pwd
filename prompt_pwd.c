#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const char LENGTH_MAX = 80;


bool starts_with(const char *string, const char *substring,
                 const size_t string_length, const size_t substring_length) {
    size_t string_size = string_length == 0 ? strlen(string) : string_length;
    size_t substring_size = substring_length == 0 ? strlen(substring) : substring_length;
    if (string_size < substring_size) {
        return false;
    } else {
        return strncmp(substring, string, substring_size) == 0;
    }
}

size_t abbr_home(const char *path, const char *home,
                 const size_t path_size, const size_t home_path_size) {
    if (starts_with(path, home, path_size, home_path_size)) {
        putchar('~');
        return home_path_size;
    } else {
        return 0;
    }
}

void shortenPath(char *path) {
    const char* home = getenv("HOME");
    const size_t path_size = strlen(path);
    const size_t home_path_size = strlen(home);

    size_t match = 0;
    for (size_t i = abbr_home(path, home, path_size, home_path_size); path[i] != '\0'; i++) {
        if (path[i] == '/') {
            putchar('/');
            const unsigned char next_byte = (const unsigned char) path[i + 1];
            // Assuming UTF-8.
            if (0x01 <= next_byte && next_byte <= 0x7F) { // ascii
                putchar(next_byte);
                match = i + 1;
            } else if (0xC0 <= next_byte && next_byte <= 0xDF) { // 2-bytes
                putchar(next_byte);
                putchar(path[i+2]);
                match = i + 2;
            } else if (0xE0 <= next_byte && next_byte <= 0xEF) { // 3-bytes
                putchar(next_byte);
                putchar(path[i+2]);
                putchar(path[i+3]);
                match = i + 3;
            } else if (0xF0 <= next_byte && next_byte <= 0xFF) { // 4-bytes
                putchar(next_byte);
                putchar(path[i+2]);
                putchar(path[i+3]);
                putchar(path[i+4]);
                match = i + 4;
            }
        }
    }
    if (match != 0) {
        for (size_t i = match + 1; path[i] != '\0'; i++) {
            putchar(path[i]);
        }
    }
}

int main(int argc, char* argv[]) {
    char path[LENGTH_MAX];
    if (argc > 1) {
        puts("Usage: pwd | prompt_pwd");
        return 0;
    } else {
        if (fgets(path, LENGTH_MAX, stdin) != NULL) {
            shortenPath(path);
            return 0;
        } else {
            return 1;
        }
    }
}
