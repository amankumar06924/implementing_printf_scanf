ASM = nasm
ASMFLAGS = -f elf64
LD = ld

TARGET = main
OBJECTS = main.o scanf.o printf.o

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) $(OBJECTS) -o $(TARGET)

main.o: main.asm
	$(ASM) $(ASMFLAGS) main.asm -o main.o

scanf.o: scanf.asm
	$(ASM) $(ASMFLAGS) scanf.asm -o scanf.o

printf.o: printf.asm
	$(ASM) $(ASMFLAGS) printf.asm -o printf.o


run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET)

