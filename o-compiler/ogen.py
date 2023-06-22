import ovm
import oscan

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


def gen_abs():
    global PC
    gen(ovm.Command.Dup)
    gen(0)
    gen(PC + 3)
    gen(ovm.Command.IfGE)
    gen(ovm.Command.Neg)


def gen_min():
    gen(oscan.MAX_INT)
    gen(ovm.Command.Neg)
    gen(1)
    gen(ovm.Command.Sub)