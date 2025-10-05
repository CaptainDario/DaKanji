# Makefile to build loadable extensions for SQLite
# Specifically, spellfix1 and compress

# 1. Configuration
# =================================
# Compiler
CC = gcc

# Directories
SRC_DIR := $(firstword $(wildcard sqlite-source-* sqlite-amalgamation-*))
EXT_DIR = ext

ifeq ($(SRC_DIR),)
$(error No 'sqlite-source-*' or 'sqlite-amalgamation-*' directory found. Please download the SQLite source zip first.)
endif

BUILD_DIR = build

# CR SQLITE SOURCES
CRSQLITE_INCLUDE_DIR = $(CRSQLITE_DIR)/core/src

# Path to the pre-built cr-sqlite static library
CRSQLITE_STATIC_LIB = $(CRSQLITE_DIR)/core/dist/crsqlite-.a

# Compiler flags
CFLAGS = -g -O2 -fPIC -shared

# LIBS are for linking external libraries
LIBS = -lpthread -ldl -lz -framework Accelerate

# 2. Build Targets
# =================================
all: loadable_spellfix_mac loadable_compress_mac

# Rule to clean up the build directory.
clean:
	@echo "==> 🧹 Cleaning up build directory..."
	@rm -rf $(BUILD_DIR)

loadable_spellfix_mac:
	gcc $(CFLAGS) -I./$(SRC_DIR) ./$(EXT_DIR)/spellfix.c -o ./$(BUILD_DIR)/spellfix.dylib

loadable_compress_mac:
	gcc $(CFLAGS) $(LIBS) -I./$(SRC_DIR) ./$(EXT_DIR)/compress.c -o ./$(BUILD_DIR)/compress.dylib