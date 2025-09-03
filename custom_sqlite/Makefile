# Makefile to build BOTH a custom SQLite shell and a dynamic library.
# This version uses a more robust, two-stage compile-then-link process.

# 1. Configuration
# =================================
# Compiler
CC = gcc

# Directories
SRC_DIR := $(firstword $(wildcard sqlite-source-* sqlite-amalgamation-*))
VEC_DIR = sqlite-vec
CRSQLITE_DIR = cr-sqlite

ifeq ($(SRC_DIR),)
$(error No 'sqlite-source-*' or 'sqlite-amalgamation-*' directory found. Please download the SQLite source zip first.)
endif

BUILD_DIR = build

# CR SQLITE SOURCES
CRSQLITE_INCLUDE_DIR = $(CRSQLITE_DIR)/core/src

# Target filenames
SHELL_EXEC = $(BUILD_DIR)/sqlite3
DYLIB_LIB = $(BUILD_DIR)/libsqlite3custom.dylib

# Path to the pre-built cr-sqlite static library
CRSQLITE_STATIC_LIB = $(CRSQLITE_DIR)/core/dist/crsqlite-.a

# Source files
# VPATH tells 'make' where to find the source files.
VPATH = $(SRC_DIR):$(VEC_DIR):$(SRC_DIR)/ext/misc

# Define source file basenames
LIB_SOURCES_NAMES = sqlite3.c sqlite-vec.c spellfix.c compress.c
SHELL_SOURCES_NAMES = shell.c

# Generate object file lists to be placed in the build directory
LIB_OBJS = $(addprefix $(BUILD_DIR)/, $(LIB_SOURCES_NAMES:.c=.o))
SHELL_OBJS = $(addprefix $(BUILD_DIR)/, $(SHELL_SOURCES_NAMES:.c=.o))
INIT_OBJ = $(BUILD_DIR)/custom_init.o

# Compiler and Linker Flags
# CFLAGS are for the compiler (-I for includes, -D for defines, -fPIC for position-independent code)
CFLAGS = -g -O2 -fPIC -I$(SRC_DIR) -I$(VEC_DIR) -I$(CRSQLITE_INCLUDE_DIR) \
         -DSQLITE_CORE \
         -DSQLITE_ENABLE_FTS5 \
		 -DSQLITE_ENABLE_DBSTAT_VTAB \
         -DSQLITE_EXTRA_INIT=sqlite3_extra_init

# LDFLAGS are for the linker
LDFLAGS = -g

# LIBS are for linking external libraries
LIBS = -lpthread -ldl -lz -framework Accelerate

# 2. Build Targets
# =================================
.PHONY: all shell dylib clean

all: shell dylib
shell: $(SHELL_EXEC)
dylib: $(DYLIB_LIB)


# 3. Build Rules
# =================================
# Rule for linking the SHELL EXECUTABLE from object files
$(SHELL_EXEC): $(LIB_OBJS) $(SHELL_OBJS) $(INIT_OBJ)
	@echo "==> 🔗 Linking executable shell: $@"
	$(CC) $(LDFLAGS) -o $@ $^ $(CRSQLITE_STATIC_LIB) $(LIBS)

# Rule for linking the DYNAMIC LIBRARY from object files
$(DYLIB_LIB): $(LIB_OBJS) $(INIT_OBJ)
	@echo "==> 🔗 Linking dynamic library: $@"
	$(CC) -dynamiclib $(LDFLAGS) -o $@ $^ $(CRSQLITE_STATIC_LIB) $(LIBS)

# Rule to compile source files from VPATH into object files in the build directory
$(BUILD_DIR)/%.o: %.c
	@echo "==> ⚙️  Compiling $<..."
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to compile the generated custom_init.c
$(INIT_OBJ): ./custom_init.c
	@echo "==> ⚙️  Compiling generated initializer $<..."
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to clean up the build directory.
clean:
	@echo "==> 🧹 Cleaning up build directory..."
	@rm -rf $(BUILD_DIR)

