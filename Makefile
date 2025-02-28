# gcc (should be downloaded in dependency-fixer)
CC = gcc

# flags (also requires dependency-fixer)
CFLAGS = -I/usr/include/python3.13 -fPIC

# linker flags (libraries i think?)
LDFLAGS = -shared -lpython3.13

# executable
TARGET = main.so

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

# run
run: $(TARGET)
	python3 -c "import main"

.PHONY: all clean run
