import oscan
import otext
from oerror import *
import otable


def compile():
    otable.open_scope()     # блок стандартных имен
    otable.enter("ABS", otable.Category.StandartProc, otable.OType.Int, otable.Function.ABS)
    otable.enter("MAX", otable.Category.StandartProc, otable.OType.Int, otable.Function.MAX)
    otable.enter("MIN", otable.Category.StandartProc, otable.OType.Int, otable.Function.MIN)
    otable.enter("DEC", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.DEC)
    otable.enter("ODD", otable.Category.StandartProc, otable.OType.Bool, otable.Function.ODD)
    otable.enter("HALT", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.HALT)
    otable.enter("INC", otable.Category.StandartProc, otable.OType.TypeNone, otable.Function.INC)
    otable.enter("INTEGER", otable.Category.catType, otable.OType.Int, 0)
    otable.open_scope()     # блок модуля
    module()
    otable.close_scope()    # блок модуля
    otable.close_scope()    # блок стандартных имен
    print("\nКомпиляция завершена")


def check(L:oscan.Lex, msg:str):
    if oscan.lex != L:
        expected(msg)
    else:
        oscan.next_lex()


def module():
    check(oscan.Lex.MODULE, "MODULE")
    if oscan.lex != oscan.Lex.Name:
        expected("имя модуля")
    else:
        module_obj = otable.new_name(oscan.namem, otable.Category.Module)
    oscan.next_lex()
    check(oscan.Lex.Semi, "';'")
    if oscan.lex == oscan.Lex.IMPORT:
        parse_import()              # import занято
    decl_seq()                      # последовательность объявлений
    if oscan.lex == oscan.Lex.BEGIN:
        oscan.next_lex()
        stat_seq()                  # последовательность операторов
    check(oscan.Lex.END, "END")
    if oscan.lex != oscan.Lex.Name:
        expected("имя модуля")
    elif oscan.name != module_obj.name:
        expected(f"имя модуля '{module_obj.name}'")
    else:
        oscan.next_lex()
    check(oscan.Lex.Dot, "'.'")


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
                check(oscan.Lex.Semim, "';'")
        else:
            oscan.next_lex()        # VAR
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

# ToDo page 226


def stat_seq():
    statement()
    while oscan.lex == oscan.Lex.Semi:
        oscan.next_lex()
        statement()


def statement():
    X = otable.ProgramObject()
    if oscan.lex == oscan.Lex.Name:
        X = otable.find(oscan.name)


def term()->otable.OType:         # слагаемое
    t = factor()        # множитель
    if oscan.lex in [oscan.Lex.Mult, oscan.Lex.DIV, oscan.Lex.MOD]:
        if t != otable.OType.Int:
            error("Несоответствие операции типу операнда")
        stop_flag = False
        while not stop_flag:
            oscan.next_lex()
            t = factor()
            if t != otable.OType.Int:
                expected("выражение целого типа")
            stop_flag = oscan.lex not in [oscan.Lex.Mult, oscan.Lex.DIV, oscan.Lex.MOD]
    return t


def factor()->otable.OType:
    X = otable.ProgramObject()
    result_type = otable.OType.TypeNone
    if oscan.lex == oscan.Lex.Name:
        X = otable.find(oscan.name)
        if X.category == otable.Category.Var:
            result_type = X.type
            oscan.next_lex()
        elif X.category == otable.Category.Const:
            result_type = X.type
            oscan.next_lex()
        elif X.category == otable.Category.StandartProc and X.type != otable.OType.TypeNone:
            oscan.next_lex()
            check(oscan.Lex.LPar, "'('")
            result_type = standartFunc(X.value)
            check(oscan.Lex.RPar, "')'")
        else:
            expected("переменная, константа или процедура-функция")
    elif oscan.lex == oscan.Lex.Num:
        result_type = otable.OType.Int
        oscan.next_lex()
    elif oscan.lex == oscan.Lex.LPar:
        oscan.next_lex()
        result_type = expression()
        check(oscan.Lex.RParm, "')'")
    else:
        expected("имя, число или '('")
    return result_type

# ПростоеВыраж [Отношение ПростоеВыраж]
def expression()->otable.OType:
    t = simple_expr()
    if oscan.lex in [oscan.Lex.EQ, oscan.Lex.NE, oscan.Lex.GT, oscan.Lex.GE, oscan.Lex.LT, oscan.Lex.LE]:
        if t != otable.OType.Int:
            error("несоответствие типу операнда")
        oscan.next_lex()
        t = simple_expr()
        if t != otable.OType.Int:
            expected("выражение целого типа")
        t = otable.OType.Bool
    return t

# ["+"|"-"] Слагаемое {ОперСлож Слагаемое}
def simple_expr()->otable.OType:
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        oscan.next_lex()
        t = term()
        if t != otable.OType.Int:
            expected("выражение целого типа")
    else:
        t = term()
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        if t != otable.OType.Int:
            error("Несоответствие операции типу операнда")
        # repeat-until imitation
        stop_flag = False
        while not stop_flag:
            oscan.next_lex()
            t = term()
            if t != otable.OType.Int:
                expected("выражение целого типа")
            stop_flag = oscan.lex not in [oscan.Lex.Plus, oscan.Lex.Minus]
    return t