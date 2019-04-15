CC=g++
INCLUDE_FLAGS=-Iinclude
DEBUG_FLAGS=
CFLAGS=-g
OBJ_DIR=obj

OBJ = $(OBJ_DIR)/alloc1.o \
	  $(OBJ_DIR)/alloc2.o \
	  $(OBJ_DIR)/copybad.o \
	  $(OBJ_DIR)/copydang.o \
	  $(OBJ_DIR)/copyunin.o \
	  $(OBJ_DIR)/deadcode.o \
	  $(OBJ_DIR)/delmis2.o \
	  $(OBJ_DIR)/readover.o \
	  $(OBJ_DIR)/leak.o 

.PHONY = clean all
	
all : $(OBJ_DIR) $(OBJ)

$(OBJ_DIR) :
	mkdir $(OBJ_DIR)

$(OBJ_DIR)/%.o : %.cpp
	$(CC) $(CFLAGS) $(INCLUDE_FLAGS) -o $@ -c $^ 

clean:
	rm -rf $(OBJ_DIR) *.out 
