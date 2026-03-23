#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define GPIO "27"
#define LED "/sys/class/leds/ACT/brightness"

void write_file(const char *path, const char *value)
{
    FILE *f = fopen(path, "w");
    if (!f)
    {
        perror("fopen");
        exit(1);
    }
    fprintf(f, "%s", value);
    fclose(f);
    printf("[BLINK] %s\n", value);
}

int main()
{
    printf("[BLINK] Started\n");
    while (1)
    {
        write_file(LED, "1");
        sleep(1);
        write_file(LED, "0");
        sleep(1);
    }
    return 0;
}
