hello: hello.o
	gcc -o hello hello.o -no-pie
hello.o: hello.asm
	nasm -f elf64 -g -F dwarf hello.asm -l hello.lst
hello-clean: 
	-rm hello.lst hello.o hello

hello2: hello2.o
	gcc -o hello2 hello2.o -no-pie
hello2.o: hello.asm
	nasm -f elf64 -g -F dwarf hello2.asm -l hello2.lst
hello2-clean: 
	-rm hello2.lst hello2.o hello2

alive: alive.o
	gcc -o alive alive.o -no-pie
alive.o: alive.asm
	nasm -f elf64 -g -F dwarf alive.asm -l alive.lst
alive-clean: 
	-rm alive.lst alive.o alive

hello4: hello4.o
	gcc -o hello4 hello4.o -no-pie
hello4.o: hello.asm
	nasm -f elf64 -g -F dwarf hello4.asm -l hello4.lst
hello4-clean: 
	-rm hello4.lst hello4.o hello4

alive2: alive2.o
	gcc -o alive2 alive2.o -no-pie
alive2.o: alive2.asm
	nasm -f elf64 -g -F dwarf alive2.asm -l alive2.lst
alive2-clean: 
	-rm alive2.lst alive2.o alive2

jump: jump.o
	gcc -o jump jump.o -no-pie
jump.o: jump.asm
	nasm -f elf64 -g -F dwarf jump.asm -l jump.lst
jump-clean: 
	-rm jump.lst jump.o jump

jumploop: jumploop.o
	gcc -o jumploop jumploop.o -no-pie
jumploop.o: jumploop.asm
	nasm -f elf64 -g -F dwarf jumploop.asm -l jumploop.lst
jumploop-clean: 
	-rm jumploop.lst jumploop.o jumploop

betterloop: betterloop.o
	gcc -o betterloop betterloop.o -no-pie
betterloop.o: betterloop.asm
	nasm -f elf64 -g -F dwarf betterloop.asm -l betterloop.lst
betterloop-clean: 
	-rm betterloop.lst betterloop.o betterloop

memory: memory.o
	gcc -o memory memory.o -no-pie
memory.o: memory.asm
	nasm -f elf64 -g -F dwarf memory.asm -l memory.lst
memory-clean: 
	-rm memory.lst memory.o memory

icalc: icalc.o
	gcc -o icalc icalc.o -no-pie
icalc.o: icalc.asm
	nasm -f elf64 -g -F dwarf icalc.asm -l icalc.lst
icalc-clean: 
	-rm icalc.lst icalc.o icalc

stack: stack.o
	gcc -o stack stack.o -no-pie
stack.o: stack.asm
	nasm -f elf64 -g -F dwarf stack.asm -l stack.lst
stack-clean: 
	-rm stack.lst stack.o stack

fcalc: fcalc.o
	gcc -o fcalc fcalc.o -no-pie
fcalc.o: fcalc.asm
	nasm -f elf64 -g -F dwarf fcalc.asm -l fcalc.lst
fcalc-clean: 
	-rm fcalc.lst fcalc.o fcalc

function: function.o
	gcc -o function function.o -no-pie
function.o: function.asm
	nasm -f elf64 -g -F dwarf function.asm -l function.lst
function-clean: 
	-rm function.lst function.o function

function2: function2.o
	gcc -o function2 function2.o -no-pie
function2.o: function2.asm
	nasm -f elf64 -g -F dwarf function2.asm -l function2.lst
function2-clean: 
	-rm function2.lst function2.o function2

aligned: aligned.o
	gcc -o aligned aligned.o -no-pie
aligned.o: aligned.asm
	nasm -f elf64 -g -F dwarf aligned.asm -l aligned.lst
aligned-clean: 
	-rm aligned.lst aligned.o aligned

function4: function4.o circle.o rect.o
	gcc -o function4 function4.o circle.o rect.o -no-pie
function4.o: function4.asm
	nasm -f elf64 -g -F dwarf function4.asm -l function4.lst
circle.o: circle.asm
	nasm -f elf64 -g -F dwarf circle.asm -l circle.lst
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst
function4-clean: 
	-rm function4.lst function4.o function4 circle.o circle.lst rect.o rect.lst

function5: function5.o
	gcc -o function5 function5.o -no-pie
function5.o: function5.asm
	nasm -f elf64 -g -F dwarf function5.asm -l function5.lst
function5-clean: 
	-rm function5.lst function5.o function5

function6: function6.o
	gcc -o function6 function6.o -no-pie
function6.o: function6.asm
	nasm -f elf64 -g -F dwarf function6.asm -l function6.lst
function6-clean: 
	-rm function6.lst function6.o function6

bits1: bits1.o printb.o
	gcc -g -o bits1 bits1.o printb.o -no-pie
bits1.o: bits1.asm
	nasm -f elf64 -g -F dwarf bits1.asm -l bits1.lst
printb: printb.c
	gcc -c printb.c
bits1-clean:
	-rm bits1.o printb.o bits1.lst bits1

bits2: bits2.o printb.o
	gcc -g -o bits2 bits2.o printb.o -no-pie
bits2.o: bits2.asm
	nasm -f elf64 -g -F dwarf bits2.asm -l bits2.lst
bits2-clean:
	-rm bits2.o printb.o bits2.lst bits2

clean: 	hello-clean hello2-clean alive-clean hello4-clean \
		alive2-clean jump-clean jumploop-clean \
		betterloop-clean memory-clean icalc-clean \
		stack-clean fcalc-clean function-clean \
		function2-clean aligned-clean function4-clean \
		function5-clean function6-clean bits1-clean \
		bits2-clean

