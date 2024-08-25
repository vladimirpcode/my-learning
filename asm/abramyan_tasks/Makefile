str_to_num.o: str_to_num.asm
	nasm -f elf64 -g -F dwarf str_to_num.asm
str_to_num-clean: 
	-rm str_to_num.o 

begin1: begin1.o str_to_num.o
	gcc -o begin1 begin1.o str_to_num.o -no-pie
begin1.o: begin1.asm
	nasm -f elf64 -g -F dwarf begin1.asm -l begin1.lst
begin1-clean: 
	-rm begin1.lst begin1.o begin1

clean: str_to_num-clean begin1-clean