import ovm

PC = 0


def init():
    global  PC
    PC = 0


def gen(cmd:int):
    global PC
    ovm.memory[PC] = cmd
    PC += 1