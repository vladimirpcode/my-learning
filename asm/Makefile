hello: hello.o
	gcc -o hello hello.o -no-pie
hello.o: hello.asm
	nasm -f elf64 -g -F dwarf hello.asm -l hello.lst
hello-clean: 
	-rm hello.lst hello.o hello

hello2:hello2.o
	gcc -o hello2 hello2.o -no-pie
hello2.o: hello.asm
	nasm -f elf64 -g -F dwarf hello2.asm -l hello2.lst
hello2-clean: 
	-rm hello2.lst hello2.o hello2

alive:alive.o
	gcc -o alive alive.o -no-pie
alive.o: alive.asm
	nasm -f elf64 -g -F dwarf alive.asm -l alive.lst
alive-clean: 
	-rm alive.lst alive.o alive

hello4:hello4.o
	gcc -o hello4 hello4.o -no-pie
hello4.o: hello.asm
	nasm -f elf64 -g -F dwarf hello4.asm -l hello4.lst
hello4-clean: 
	-rm hello4.lst hello4.o hello4

alive2:alive2.o
	gcc -o alive2 alive2.o -no-pie
alive2.o: alive2.asm
	nasm -f elf64 -g -F dwarf alive2.asm -l alive2.lst
alive2-clean: 
	-rm alive2.lst alive2.o alive2

jump:jump.o
	gcc -o jump jump.o -no-pie
jump.o: jump.asm
	nasm -f elf64 -g -F dwarf jump.asm -l jump.lst
jump-clean: 
	-rm jump.lst jump.o jump

jumploop:jumploop.o
	gcc -o jumploop jumploop.o -no-pie
jumploop.o: jumploop.asm
	nasm -f elf64 -g -F dwarf jumploop.asm -l jumploop.lst
jumploop-clean: 
	-rm jumploop.lst jumploop.o jumploop

betterloop:betterloop.o
	gcc -o betterloop betterloop.o -no-pie
betterloop.o: betterloop.asm
	nasm -f elf64 -g -F dwarf betterloop.asm -l betterloop.lst
betterloop-clean: 
	-rm betterloop.lst betterloop.o betterloop

memory:memory.o
	gcc -o memory memory.o -no-pie
memory.o: memory.asm
	nasm -f elf64 -g -F dwarf memory.asm -l memory.lst
memory-clean: 
	-rm memory.lst memory.o memory

icalc:icalc.o
	gcc -o icalc icalc.o -no-pie
icalc.o: icalc.asm
	nasm -f elf64 -g -F dwarf icalc.asm -l icalc.lst
icalc-clean: 
	-rm icalc.lst icalc.o icalc

stack:stack.o
	gcc -o stack stack.o -no-pie
stack.o: stack.asm
	nasm -f elf64 -g -F dwarf stack.asm -l stack.lst
stack-clean: 
	-rm stack.lst stack.o stack

fcalc:fcalc.o
	gcc -o fcalc fcalc.o -no-pie
fcalc.o: fcalc.asm
	nasm -f elf64 -g -F dwarf fcalc.asm -l fcalc.lst
fcalc-clean: 
	-rm fcalc.lst fcalc.o fcalc

clean: 	hello-clean hello2-clean alive-clean hello4-clean \
		alive2-clean jump-clean jumploop-clean \
		betterloop-clean memory-clean icalc-clean \
		stack-clean fcalc-clean \
