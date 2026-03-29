#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

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
}

int get_unit(void)
{
    // 1 unit = 300ms
    return 150 * 1000;
}

void blink(const int arg_time)
{
    write_file(LED, "1");
    usleep(arg_time * get_unit());
    write_file(LED, "0");
    usleep(1 * get_unit());
}

void blink_short(void)
{
    blink(1);
}

void blink_long(void)
{
    blink(3);
}

void word_pause(void)
{
    usleep(7 * get_unit());
}

void print_sos(void)
{
    printf("[BLINK] S\n");
    blink_short();
    blink_short();
    blink_short();

    printf("[BLINK] O\n");
    blink_long();
    blink_long();
    blink_long();

    printf("[BLINK] S\n");
    blink_short();
    blink_short();
    blink_short();

    printf("[BLINK]  \n");
    word_pause();
}

int main()
{
    printf("[BLINK] Started\n");
    while (1)
    {
        print_sos();
    }

    return 0;
}
