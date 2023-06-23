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
        gen(ovm.Command.Neg.value)


def gen_abs():
    global PC
    gen(ovm.Command.Dup.value)
    gen(0)
    gen(PC + 3)
    gen(ovm.Command.IfGE.value)
    gen(ovm.Command.Neg.value)


def gen_min():
    gen(oscan.MAX_INT)
    gen(ovm.Command.Neg.value)
    gen(1)
    gen(ovm.Command.Sub.value)


def gen_odd():
    gen(2)
    gen(ovm.Command.MOD.value)
    gen(0)
    gen(0)      # фиктивный адрес перехода вперед
    gen(ovm.Command.IfEQ.value)


def gen_comp(operation:oscan.Lex):
    gen(0)      # фиктивный адрес перехода вперед
    match operation:
        case oscan.Lex.EQ: gen(ovm.Command.IfNE.value)
        case oscan.Lex.NE: gen(ovm.Command.IfEQ.value)
        case oscan.Lex.LE: gen(ovm.Command.IfGT.value)
        case oscan.Lex.LT: gen(ovm.Command.IfGE.value)
        case oscan.Lex.LE: gen(ovm.Command.IfGT.value)
        case oscan.Lex.LT: gen(ovm.Command.IfGE.value)