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

begin2: begin2.o str_to_num.o
	gcc -o begin2 begin2.o str_to_num.o -no-pie
begin2.o: begin2.asm
	nasm -f elf64 -g -F dwarf begin2.asm -l begin2.lst
begin2-clean: 
	-rm begin2.lst begin2.o begin2

begin3: begin3.o str_to_num.o
	gcc -o begin3 begin3.o str_to_num.o -no-pie
begin3.o: begin3.asm
	nasm -f elf64 -g -F dwarf begin3.asm -l begin3.lst
begin3-clean: 
	-rm begin3.lst begin3.o begin3

begin4: begin4.o str_to_num.o
	gcc -o begin4 begin4.o str_to_num.o -no-pie
begin4.o: begin4.asm
	nasm -f elf64 -g -F dwarf begin4.asm -l begin4.lst
begin4-clean: 
	-rm begin4.lst begin4.o begin4

begin5: begin5.o str_to_num.o
	gcc -o begin5 begin5.o str_to_num.o -no-pie
begin5.o: begin5.asm
	nasm -f elf64 -g -F dwarf begin5.asm -l begin5.lst
begin5-clean: 
	-rm begin5.lst begin5.o begin5

clean: str_to_num-clean begin1-clean begin2-clean begin3-clean \
	begin4-clean begin5-clean