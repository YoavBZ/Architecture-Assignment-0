all: myexe.out

myexe.out: main_ass0.o asm_ass0.o
	gcc -g -Wall -o myexe.out main_ass0.o asm_ass0.o

main_ass0.o: main_ass0.c
	gcc -g -Wall -c -o main_ass0.o main_ass0.c 
 
asm_ass0.o: asm_ass0.s
	nasm -g -f elf64 -w+all -o asm_ass0.o asm_ass0.s


#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o myexe.out