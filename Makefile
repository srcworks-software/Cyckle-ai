PYTHON = python3

PYTHON_INCLUDE = $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('include'))")
PYTHON_LIB = $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
PYTHON_VERSION = $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_config_var('VERSION'))")

CC = gcc
CFLAGS = -I$(PYTHON_INCLUDE) -fPIC
LDFLAGS = -shared -L$(PYTHON_LIB) -lpython$(PYTHON_VERSION)

TARGET = main.so
C_SRC = main.c
OBJ = main.o

all: $(TARGET)

$(OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c $(C_SRC) -o $(OBJ)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

clean:
	rm -f $(TARGET) $(OBJ) *.pyc __pycache__/*

run: $(TARGET)
	$(PYTHON) -c "import main"

.PHONY: all clean run
