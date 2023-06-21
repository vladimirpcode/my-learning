import ovm

PC = 0


def init():
    global  PC
    PC = 0


def gen(cmd:int):
    global PC
    ovm.memory[PC] = cmd
    PC += 1


def gen_const(c:int):
    gen(abs(c))
    if c < 0:
        gen(ovm.Command.Neg)