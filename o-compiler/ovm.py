from enum import Enum

class Command(Enum):
    Stop = -1
    Add = -2
    Sub = -3
    Mult = -4
    Div = -5
    Mod = -6
    Neg = -7
    Load = -8
    Save = -9
    Dup = -10
    Drop = -11
    Swap = -12
    Over = -13
    GOTO = -14
    IfEQ = -15
    IfNE = -16
    IfLE = -17
    IfLT = -18
    IfGE = -19
    IfGT = -20
    In = -21
    Out = -22
    OutLn = -23


MEM_SIZE = 8 * 1024

memory = [0] * MEM_SIZE

def run():
    SP = MEM_SIZE   # стек пуст
    PC = 0
    cmd = memory[PC]
    while cmd != Command.Stop.value:
        PC += 1
        if cmd >= 0:
            SP = SP - 1
            memory[SP] = cmd
        else:
            match cmd:
                case Command.Add.value:
                    SP += 1
                    memory[SP] = memory[SP] + memory[SP-1]
                case Command.Sub.value:
                    SP += 1
                    memory[SP] = memory[SP] - memory[SP-1]
                case Command.Mult.value:
                    SP += 1
                    memory[SP] = memory[SP] * memory[SP-1]
                case Command.Div.value:
                    SP += 1
                    memory[SP] = memory[SP] // memory[SP-1]
                case Command.Mod.value:
                    SP += 1
                    memory[SP] = memory[SP] % memory[SP-1]
                case Command.Neg.value:
                    memory[SP] = -memory[SP]
                case Command.Load.value:
                    memory[SP] = memory[memory[SP]]
                case Command.Save.value:
                    memory[memory[SP+1]] = memory[SP]
                    SP += 2
                case Command.Dup.value:
                    SP -= 1
                    memory[SP] = memory[SP+1]
                case Command.Drop.value:
                    SP += 1
                case Command.Swap.value:
                    buf = memory[SP]
                    memory[SP] = memory[SP+1]
                    memory[SP+1] = buf
                case Command.Over.value:
                    SP -= 1
                    memory[SP] = memory[SP+2]
                case Command.GOTO.value:
                    PC = memory[SP]
                    SP += 1
                case Command.IfEQ.value:
                    if memory[SP+2] == memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.IfNE.value:
                    if memory[SP+2] != memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.IfLE.value:
                    if memory[SP+2] <= memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.IfLT.value:
                    if memory[SP+2] < memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.IfGE.value:
                    if memory[SP+2] >= memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.IfGT.value:
                    if memory[SP+2] > memory[SP+1]:
                        PC = memory[SP]
                    SP += 3
                case Command.In.value:
                    SP -= 1
                    print("?")
                    memory[SP] = int(input())
                case Command.Out.value:
                    print(str(memory[SP+1]).ljust(memory[SP]), end="")
                    SP += 2
                case Command.OutLn.value:
                    print()
                case _:
                    print("Недопустимый код операции")
                    memory[PC] = Command.Stop.value
            cmd = memory[PC]
    print()
    if SP < MEM_SIZE:
        print(f"код возврата {memory[SP]}")
