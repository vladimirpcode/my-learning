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

begin6: begin6.o str_to_num.o
	gcc -o begin6 begin6.o str_to_num.o -no-pie
begin6.o: begin6.asm
	nasm -f elf64 -g -F dwarf begin6.asm -l begin6.lst
begin6-clean: 
	-rm begin6.lst begin6.o begin6

begin7: begin7.o str_to_num.o
	gcc -o begin7 begin7.o str_to_num.o -no-pie
begin7.o: begin7.asm
	nasm -f elf64 -g -F dwarf begin7.asm -l begin7.lst
begin7-clean: 
	-rm begin7.lst begin7.o begin7

begin8: begin8.o str_to_num.o
	gcc -o begin8 begin8.o str_to_num.o -no-pie
begin8.o: begin8.asm
	nasm -f elf64 -g -F dwarf begin8.asm -l begin8.lst
begin8-clean: 
	-rm begin8.lst begin8.o begin8

begin9: begin9.o str_to_num.o
	gcc -o begin9 begin9.o str_to_num.o -no-pie
begin9.o: begin9.asm
	nasm -f elf64 -g -F dwarf begin9.asm -l begin9.lst
begin9-clean: 
	-rm begin9.lst begin9.o begin9

begin10: begin10.o str_to_num.o
	gcc -o begin10 begin10.o str_to_num.o -no-pie
begin10.o: begin10.asm
	nasm -f elf64 -g -F dwarf begin10.asm -l begin10.lst
begin10-clean: 
	-rm begin10.lst begin10.o begin10

clean: str_to_num-clean begin1-clean begin2-clean begin3-clean \
	begin4-clean begin5-clean begin6-clean begin7-clean begin8-clean \
	begin9-clean begin10-clean