import otable
import ovm
import oscan
from oerror import *

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
        case oscan.Lex.GE: gen(ovm.Command.IfLT.value)
        case oscan.Lex.GT: gen(ovm.Command.IfLE.value)


def fixup(addr:int):
    temp = 0
    while addr > 0:
        temp = ovm.memory[addr-2]
        ovm.memory[addr-2] = PC
        addr = temp


def gen_addr(program_object:otable.ProgramObject)->otable.ProgramObject:
    global PC
    gen(program_object.value)
    program_object.value = PC + 1
    return program_object


def allocate_variables():
    global PC
    program_obj = otable.first_var()
    while program_obj != None:
        if program_obj.value == 0:
            warning(f"переменная {program_obj.name} не используется")
        else:
            fixup(program_obj.value)
            PC += 1
        program_obj = otable.next_var()