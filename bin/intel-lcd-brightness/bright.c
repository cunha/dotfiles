#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define STRLEN 256
#define BRIGHTNESS_FN "/sys/class/backlight/intel_backlight/brightness"
#define MAX_BRIGHTNESS_FN "/sys/class/backlight/intel_backlight/max_brightness"
#define MIN_BRIGHTNESS 50
#define STEP 100

void usage(int argc, const char **argv)/*{{{*/
{
	printf("usage: %s up|down|int\n", argv[0]);
	printf("\n");
}
/*}}}*/

void die(const char *fmt, ...)/*{{{*/
{
	va_list ap;
	va_start(ap,fmt);
	if(!vprintf(fmt, ap)) printf("error printing error message.\n");
	va_end(ap);
	exit(EXIT_FAILURE);
}
/*}}}*/

int parse_first_line(const char *fn)/*{{{*/
{
	FILE *fd = fopen(fn, "r");
	if(!fd) die("could not open %s\n", fn);
	char line[STRLEN];
	fgets(line, STRLEN, fd);
	if(strlen(line) >= STRLEN-1) die("could not read from %s\n", fn);
	int value;
	if(1 != sscanf(line, "%d\n", &value)) exit(EXIT_FAILURE);
	return value;
}
/*}}}*/

int main(int argc, const char **argv)
{
	if(argc != 2) usage(argc, argv);

	int target;
	if(0 == strncmp(argv[1], "up", strlen("up"))) {
		int base = parse_first_line(BRIGHTNESS_FN);
		target = base + STEP;
	} else if(0 == strncmp(argv[1], "down", strlen("down"))) {
		int base = parse_first_line(BRIGHTNESS_FN);
		target = base - STEP;
	} else if(1 != sscanf(argv[1], "%d\n", &target)) {
		printf("invalid target brightness.\n");
		usage(argc, argv);
	}

	int max = parse_first_line(MAX_BRIGHTNESS_FN);
	if(target > max) target = max;
	else if(target <= 0) target = MIN_BRIGHTNESS;

	FILE *outfd = fopen(BRIGHTNESS_FN, "w");
	if(!outfd) die("could not open %s for writing\n", BRIGHTNESS_FN);
	if(fprintf(outfd, "%d\n", target) < 0) {
		die("could not write %s", BRIGHTNESS_FN);
	}
	fclose(outfd);
	
	exit(EXIT_SUCCESS);
}
