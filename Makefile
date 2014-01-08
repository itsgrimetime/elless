CC = gcc

all: ls.o
	$(CC) -o ls ls.o

