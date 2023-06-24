import oscan
import otext
from oerror import *
import otable
import ogen
import ovm


def compile_o():
    otable.open_scope()  # блок стандартных имен
    otable.enter("ABS", otable.Category.StandartProc, otable.OType.Int, otable.Function.ABS)
    otable.enter("MAX", otable.Category.StandartProc, otable.OType.Int, otable.Function.MAX)
    otable.enter("MIN", otable.Category.StandartProc, otable.OType.Int, otable.Function.MIN)
    otable.enter("DEC", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.DEC)
    otable.enter("ODD", otable.Category.StandartProc, otable.OType.Bool, otable.Function.ODD)
    otable.enter("HALT", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.HALT)
    otable.enter("INC", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.INC)
    otable.enter("INTEGER", otable.Category.catType, otable.OType.Int, 0)
    otable.open_scope()  # блок модуля
    module()
    otable.close_scope()  # блок модуля
    otable.close_scope()  # блок стандартных имен
    print("\nКомпиляция завершена")


def check(L: oscan.Lex, msg: str):
    if oscan.lex != L:
        expected(msg)
    else:
        oscan.next_lex()


def module():
    check(oscan.Lex.MODULE, "MODULE")
    if oscan.lex != oscan.Lex.Name:
        expected("имя модуля")
    module_obj = otable.new_name(oscan.name, otable.Category.Module)
    oscan.next_lex()
    check(oscan.Lex.Semi, "';'")
    if oscan.lex == oscan.Lex.IMPORT:
        parse_import()  # import
    decl_seq()  # последовательность объявлений
    if oscan.lex == oscan.Lex.BEGIN:
        oscan.next_lex()
        stat_seq()  # последовательность операторов
    check(oscan.Lex.END, "END")
    if oscan.lex != oscan.Lex.Name:
        expected("имя модуля")
    elif oscan.name != module_obj.name:
        expected(f"имя модуля '{module_obj.name}'")
    else:
        oscan.next_lex()
    check(oscan.Lex.Dot, "'.'")
    ogen.gen(0)
    ogen.gen(ovm.Command.Stop.value)
    ogen.allocate_variables()


def parse_import():
    check(oscan.Lex.IMPORT, "IMPORT")
    import_module()
    while oscan.lex == oscan.Lex.Comma:
        oscan.next_lex()
        import_module()
    check(oscan.Lex.Semi, "';'")


def import_module():
    if oscan.lex == oscan.Lex.Name:
        module_obj = otable.new_name(oscan.name, otable.Category.Module)
        match oscan.name:
            case "In":
                otable.enter("In.Open", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.InOpen)
                otable.enter("In.Int", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.InInt)
            case "Out":
                otable.enter("Out.Int", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.OutInt)
                otable.enter("Out.Ln", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.OutLn)
            case _:
                error(f"Неизвестный модуль {oscan.name}")
        oscan.next_lex()
    else:
        expected("имя импортируемого модуля")


def decl_seq():
    while oscan.lex in [oscan.Lex.CONST, oscan.Lex.VAR]:
        if oscan.lex == oscan.Lex.CONST:
            oscan.next_lex()
            while oscan.lex == oscan.Lex.Name:
                const_decl()
                check(oscan.Lex.Semi, "';'")
        else:
            oscan.next_lex()  # VAR
            while oscan.lex == oscan.Lex.Name:
                var_decl()
                check(oscan.Lex.Semi, "';'")


def const_decl():
    const_obj = otable.new_name(oscan.name, otable.Category.Guard)
    oscan.next_lex()
    check(oscan.Lex.EQ, "'='")
    const_obj.value = const_expr()
    const_obj.type = otable.OType.Int
    const_obj.category = otable.Category.Const
    otable.program_objects[-1] = const_obj


# ["+" | "-"] (Число | Имя)
def const_expr() -> int:
    result_value = 0
    program_obj = otable.ProgramObject()
    op = oscan.Lex.Plus
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        op = oscan.lex
        oscan.next_lex()
    if oscan.lex == oscan.Lex.Num:
        result_value = oscan.num
        oscan.next_lex()
    elif oscan.lex == oscan.Lex.Name:
        program_obj = otable.find(oscan.name)
        if program_obj.category == otable.Category.Guard:
            error("нельзя определять константу через себя")
        elif program_obj.category != otable.Category.Const:
            expected("имя константы")
        else:
            result_value = program_obj.value
        oscan.next_lex()
    else:
        expected("константное выражение")
    if op == oscan.Lex.Minus:
        result_value = -result_value
    return result_value


def var_decl():
    program_obj = otable.ProgramObject()
    if oscan.lex != oscan.Lex.Name:
        expected("Имя")
    else:
        program_obj = otable.new_name(oscan.name, otable.Category.Var)
        program_obj.type = otable.OType.Int
        otable.program_objects[-1] = program_obj
        oscan.next_lex()
    while oscan.lex == oscan.Lex.Comma:
        oscan.next_lex()
        if oscan.lex != oscan.Lex.Name:
            expected("Имя")
        else:
            program_obj = otable.new_name(oscan.name, otable.Category.Var)
            program_obj.type = otable.OType.Int
            otable.program_objects[-1] = program_obj
            oscan.next_lex()
    check(oscan.Lex.Colon, "':'")
    parse_type()


def stat_seq():
    statement()
    while oscan.lex == oscan.Lex.Semi:
        oscan.next_lex()
        statement()


def statement():
    program_obj = otable.ProgramObject()
    if oscan.lex == oscan.Lex.Name:
        program_obj = otable.find(oscan.name)
        if program_obj.category == otable.Category.Module:
            oscan.next_lex()
            check(oscan.Lex.Dot, "'.'")
            if oscan.lex == oscan.Lex.Name and len(program_obj.name) < oscan.MAX_NAME_LEN:
                program_obj = otable.find(program_obj.name + "." + oscan.name)
            else:
                expected(f"имя из модуля {program_obj.name}")
        if program_obj.category == otable.Category.Var:
            ass_statement()
        elif program_obj.category == otable.Category.StandartProc and program_obj.type == otable.OType.TypeNone:
            call_statement(program_obj.value)
        else:
            expected("обозначение переменной или процедуры")
    elif oscan.lex == oscan.Lex.IF:
        if_statement()
    elif oscan.lex == oscan.Lex.WHILE:
        while_statement()

# ПростоеВыраж [Отношение ПростоеВыраж]
def expression() -> otable.OType:
    operation = oscan.Lex.lexNone
    t = simple_expr()
    if oscan.lex in [oscan.Lex.EQ, oscan.Lex.NE, oscan.Lex.GT, oscan.Lex.GE, oscan.Lex.LT, oscan.Lex.LE]:
        operation = oscan.lex
        if t != otable.OType.Int:
            error("несоответствие типу операнда")
        oscan.next_lex()
        t = simple_expr()
        if t != otable.OType.Int:
            expected("выражение целого типа")
        ogen.gen_comp(operation)
        t = otable.OType.Bool
    return t


# ["+"|"-"] Слагаемое {ОперСлож Слагаемое}
def simple_expr() -> otable.OType:
    operation = oscan.Lex.lexNone
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        operation = oscan.lex
        oscan.next_lex()
        t = term()
        if t != otable.OType.Int:
            expected("выражение целого типа")
        if operation == oscan.Lex.Minus:
            ogen.gen(ovm.Command.Neg.value)
    else:
        t = term()
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        if t != otable.OType.Int:
            error("Несоответствие операции типу операнда")
        # repeat-until imitation
        stop_flag = False
        while not stop_flag:
            operation = oscan.lex
            oscan.next_lex()
            t = term()
            if t != otable.OType.Int:
                expected("выражение целого типа")
            match operation:
                case oscan.Lex.Plus: ogen.gen(ovm.Command.Add.value)
                case oscan.Lex.Minus: ogen.gen(ovm.Command.Sub.value)
            stop_flag = oscan.lex not in [oscan.Lex.Plus, oscan.Lex.Minus]
    return t


def term() -> otable.OType:  # слагаемое
    t = factor()  # множитель
    operation = oscan.Lex.lexNone
    if oscan.lex in [oscan.Lex.Mult, oscan.Lex.DIV, oscan.Lex.MOD]:
        if t != otable.OType.Int:
            error("Несоответствие операции типу операнда")
        stop_flag = False
        while not stop_flag:
            operation = oscan.lex
            oscan.next_lex()
            t = factor()
            if t != otable.OType.Int:
                expected("выражение целого типа")
            match operation:
                case oscan.Lex.Mult: ogen.gen(ovm.Command.Mult.value)
                case oscan.Lex.DIV: ogen.gen(ovm.Command.DIV.value)
                case oscan.Lex.MOD: ogen.gen(ovm.Command.MOD.value)
            stop_flag = oscan.lex not in [oscan.Lex.Mult, oscan.Lex.DIV, oscan.Lex.MOD]
    return t


def factor() -> otable.OType:
    program_obj = otable.ProgramObject()
    result_type = otable.OType.TypeNone
    if oscan.lex == oscan.Lex.Name:
        program_obj = otable.find(oscan.name)
        if program_obj.category == otable.Category.Var:
            program_obj = ogen.gen_addr(program_obj)
            ogen.gen(ovm.Command.Load.value)
            result_type = program_obj.type
            oscan.next_lex()
        elif program_obj.category == otable.Category.Const:
            ogen.gen_const(program_obj.value)
            result_type = program_obj.type
            oscan.next_lex()
        elif program_obj.category == otable.Category.StandartProc and program_obj.type != otable.OType.TypeNone:
            oscan.next_lex()
            check(oscan.Lex.LPar, "'('")
            result_type = standart_func(program_obj.value)
            check(oscan.Lex.RPar, "')'")
        else:
            expected("переменная, константа или процедура-функция")
    elif oscan.lex == oscan.Lex.Num:
        result_type = otable.OType.Int
        ogen.gen_const(oscan.num)
        oscan.next_lex()
    elif oscan.lex == oscan.Lex.LPar:
        oscan.next_lex()
        result_type = expression()
        check(oscan.Lex.RPar, "')'")
    else:
        expected("имя, число или '('")
    return result_type


def int_expressipon():
    result_type = expression()
    if result_type != otable.OType.Int:
        expected("выражение целого типа")


def bool_expression():
    result_type = expression()
    if result_type != otable.OType.Bool:
        expected("логическое выражение")


def standart_func(value:otable.Function)->otable.OType:
    result_type = otable.OType.TypeNone
    match value:
        case otable.Function.ABS:
            int_expressipon()
            ogen.gen_abs()
            result_type = otable.OType.Int
        case otable.Function.MAX:
            parse_type()
            ogen.gen(oscan.MAX_INT)
            result_type = otable.OType.Int
        case otable.Function.MIN:
            parse_type()
            ogen.gen_min()
            result_type = otable.OType.Int
        case otable.Function.ODD:
            int_expressipon()
            ogen.gen_odd()
            result_type = otable.OType.Bool
    return result_type


def ass_statement():
    variable()
    if oscan.lex == oscan.Lex.Ass:
        oscan.next_lex()
        int_expressipon()
        ogen.gen(ovm.Command.Save.value)
    else:
        expected("':='")


def variable():
    program_obj = otable.ProgramObject()
    if oscan.lex != oscan.Lex.Name:
        expected("имя")
    else:
        program_obj = otable.find(oscan.name)
        if program_obj.category != otable.Category.Var:
            expected("имя переменной")
        program_obj = ogen.gen_addr(program_obj)
        oscan.next_lex()


def call_statement(proc:otable.Function):
    check(oscan.Lex.Name, "имя процедуры")
    if oscan.lex == oscan.Lex.LPar:
        oscan.next_lex()
        standart_proc(proc)
        check(oscan.Lex.RPar, "')'")
    elif proc in [otable.Function.OutLn, otable.Function.InOpen]:
        standart_proc(proc)
    else:
        expected("'('")


def standart_proc(proc:otable.Function):
    match proc:
        case otable.Function.DEC:
            variable()
            ogen.gen(ovm.Command.Dup.value)
            ogen.gen(ovm.Command.Load.value)
            if oscan.lex == oscan.Lex.Comma:
                oscan.next_lex()
                int_expressipon()
            else:
                ogen.gen(1)
            ogen.gen(ovm.Command.Sub.value)
            ogen.gen(ovm.Command.Save.value)
        case otable.Function.INC:
            variable()
            ogen.gen(ovm.Command.Dup.value)
            ogen.gen(ovm.Command.Load.value)
            if oscan.lex == oscan.Lex.Comma:
                oscan.next_lex()
                int_expressipon()
            else:
                ogen.gen(1)
            ogen.gen(ovm.Command.Add.value)
            ogen.gen(ovm.Command.Save.value)
        case otable.Function.InOpen: pass
        case otable.Function.InInt:
            variable()
            ogen.gen(ovm.Command.In.value)
            ogen.gen(ovm.Command.Save.value)
        case otable.Function.OutInt:
            int_expressipon()
            check(oscan.Lex.Comma, "','")
            int_expressipon()
            ogen.gen(ovm.Command.Out.value)
        case otable.Function.OutLn:
            ogen.gen(ovm.Command.OutLn.value)
        case otable.Function.HALT:
            c = const_expr()
            ogen.gen_const(c)
            ogen.gen(ovm.Command.Stop.value)


def while_statement():
    while_PC = 0
    cond_PC = 0
    while_PC = ogen.PC
    check(oscan.Lex.WHILE, "WHILE")
    bool_expression()
    cond_PC = ogen.PC
    check(oscan.Lex.DO, "DO")
    stat_seq()
    check(oscan.Lex.END, "END")
    ogen.gen(while_PC)
    ogen.gen(ovm.Command.GOTO.value)
    ogen.fixup(cond_PC)


def if_statement():
    cond_PC = 0
    last_GOTO = 0
    check(oscan.Lex.IF, "IF")
    last_GOTO = 0
    bool_expression()
    cond_PC = ogen.PC
    check(oscan.Lex.THEN, "THEN")
    stat_seq()
    while oscan.lex == oscan.Lex.ELSIF:
        ogen.gen(last_GOTO)
        ogen.gen(ovm.Command.GOTO.value)
        last_GOTO = ogen.PC
        oscan.next_lex()
        ogen.fixup(cond_PC)
        bool_expression()
        cond_PC = ogen.PC
        check(oscan.Lex.THEN, "THEN")
        stat_seq()
    if oscan.lex == oscan.Lex.ELSE:
        ogen.gen(last_GOTO)
        ogen.gen(ovm.Command.GOTO.value)
        last_GOTO = ogen.PC
        oscan.next_lex()
        ogen.fixup(cond_PC)
        stat_seq()
    else:
        ogen.fixup(cond_PC)
    check(oscan.Lex.END, "END")
    ogen.fixup(last_GOTO)


def parse_type():
    program_obj = otable.ProgramObject()
    if oscan.lex != oscan.Lex.Name:
        expected("имя")
    else:
        program_obj = otable.find(oscan.name)
        if program_obj.category != otable.Category.catType:
            expected("имя типа")
        elif program_obj.type != otable.OType.Int:
            expected("целый тип")
        oscan.next_lex()




