# gcc (should be downloaded in dependency-fixer)
CC = gcc

# flags (also requires dependency-fixer)
CFLAGS = -I/usr/include/python3.13

# linker flags (libraries i think?)
LDFLAGS = -lpython3.13

# executable
TARGET = main

# source (c code)
SRCS = main.c

OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# clean
clean:
	rm -f $(OBJS) $(TARGET)

# Run the program
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run