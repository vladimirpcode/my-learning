begin1: begin1.o
	gcc -o begin1 begin1.o -no-pie
begin1.o: begin1.asm
	nasm -f elf64 -g -F dwarf begin1.asm -l begin1.lst
begin1-clean: 
	-rm begin1.lst begin1.o begin1

cbegin1: cbegin1.o
	gcc cbegin1.o -o cbegin1 -no-pie
cbegin1.o: cbegin1.c
	gcc -c cbegin1.c
cbegin1-clean:
	-rm cbegin1 cbegin1.o


clean: begin1-clean cbegin1-clean