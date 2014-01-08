#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

#define debug 0

struct file {
    char* name;
    time_t mtime;
};

time_t get_mtime(const char *path);

int main(int argc, char** argv) {

    DIR *dir;
    struct dirent *dp;
    int has_target;
    int time_sort;
    char *target;
    time_t mtime;

    struct file *file_arr;

    char *dot = ".";

    if (argc >= 2) {
	if (strncmp(argv[1], "-t", 2) == 0) {
	    time_sort = 1;
	    has_target = 0;
	} else {
	    time_sort = 0;
	    has_target = 1;
	    target = (char*) malloc(strlen(argv[1]));
	    strncpy(target, argv[1], strlen(argv[1]));
	    if (debug) printf("got target of %s\n", target);
	}
    } else {
	if (debug) printf("no target\n");
	target = (char*) malloc(2);
	strncpy(target, dot, 2);
	has_target = 0;
    }

    dir = opendir(target);

    if (dir == NULL) {
	return -1;
    }

    char path[1024];

    while ((dp = readdir(dir)) != NULL) {
	if (dp->d_name[0] != '.') {
	    if (time_sort) {
		file_arr = (struct file*) malloc(sizeof(struct file));
		strncpy(path, target, strlen(target));
		if (target[strlen(target)] != '/') {
		    strncat(path, "/", 1);
		}
		strncat(path, dp->d_name, strlen(dp->d_name));
		printf("looking for this path: %s\n", path);
		file_arr->name = (char *) malloc(strlen(dp->d_name) + 1);
		strncpy(file_arr->name, dp->d_name, strlen(dp->d_name));
		mtime = get_mtime(path);
		file_arr->mtime = mtime;
		printf("file_arr->time: %ld, file_arr->name%s\n", file_arr->mtime, file_arr->name);
		file_arr += sizeof(struct file);
	    } else {
		printf("%s\n", dp->d_name);
	    }
	}
	bzero(path, 1024);
    }

    free(target);
    closedir(dir);
    return 0;

}

time_t get_mtime(const char *path) {
    struct stat statbuf;
    if (stat(path, &statbuf) == -1) {
	perror(path);
	exit(1);
    }
    return statbuf.st_mtime;
}
