#
# SDCC Makefile
#

# ------------------------------------------------------
# Directories
SRCDIR      = src
INCDIR      = include
OBJDIR      = obj
OUTPUT_DIR  = bin
TARGET      = $(OUTPUT_DIR)/sdcc-parameter-test.hex


# ------------------------------------------------------
# File Discovery (recursive)
PRJ_SOURCE  = $(notdir $(wildcard $(SRCDIR)/*.c))
PRJ_OBJECTS := $(addprefix $(OBJDIR)/, $(PRJ_SOURCE:.c=.rel))



# ------------------------------------------------------
# Compiler/Linker Settings
CC          = "C:\Program Files\SDCC\bin\sdcc.exe"
AS          = "C:\Program Files\SDCC\bin\sdas8051.exe"
MODEL       = small

# Include paths (from build log)
INCLUDE_PATHS = -I$(INCDIR) \
    -I"C:/Program Files/SDCC/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libmf/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libmfcrypto/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdvk2/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5031/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5042/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5043/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5051/include" \
    -I"C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdsp/include"

# Library paths (from build log)
LIB_PATHS = -L"C:/Program Files/SDCC/lib" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libreent/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libmf/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libmfcrypto/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdvk2/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5031/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5042/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5043/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5051/sdcc" \
    -L"C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdsp/sdcc"

# Libraries to link (from build log)
LIBS        = -llibmf -llibaxdvk2

# Compiler flags
COMMON_FLAGS = -mmcs51 --verbose --debug -DBUILD
CFLAGS      = $(COMMON_FLAGS) --model-$(MODEL) $(INCLUDE_PATHS)
CPPFLAGS    = $(COMMON_FLAGS) --model-$(MODEL) $(INCLUDE_PATHS)

# Linker flags
LDFLAGS     = $(COMMON_FLAGS) $(LIB_PATHS) $(LIBS) \
    --code-size 59389 \
    --xram-size 8192 \
    --iram-size 256

# ------------------------------------------------------
# Build Rules
.PHONY: all clean create_dirs

all: create_dirs $(TARGET)

create_dirs:
	@echo "Creating directories if they don't exist..."
	@echo $(TARGET)
	@echo $(PRJ_SOURCE)
	@echo $(PRJ_OBJECTS)
	@if not exist "$(SRCDIR)" mkdir "$(SRCDIR)"
	@if not exist "$(INCDIR)" mkdir "$(INCDIR)"
	@if not exist "$(OBJDIR)" mkdir "$(OBJDIR)"
	@if not exist "$(OUTPUT_DIR)" mkdir "$(OUTPUT_DIR)"

$(OBJDIR)/%.rel: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(PRJ_OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

clean:
	@echo Cleaning objects...
	@if exist "$(OBJDIR)" ( \
		cd "$(OBJDIR)" && \
		dir /a-d /b 2>nul | findstr "." >nul && (\
			del /Q /S *.* \
		) || (\
			echo Nothing to clean \
		) \
	)
	@echo Cleaning objects...
	@if exist "$(OUTPUT_DIR)" ( \
		cd "$(OUTPUT_DIR)" && \
		dir /a-d /b 2>nul | findstr "." >nul && (\
			del /Q /S *.* \
		) || (\
			echo Nothing to clean \
		) \
	)