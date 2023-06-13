import oscan
import otext
from oerror import *
from enum import Enum


class OType(Enum):
    Int = 1
    Bool = 2


def compile():
    module()
    print("Компиляция завершена")


def check(L:oscan.Lex, msg:str):
    if oscan.lex != L:
        expected(msg)
    else:
        oscan.next_lex()


def module():
    check(oscan.Lex.MODULE, "MODULE")
    check(oscan.Lex.Name, "имя модуля")
    check(oscan.Lex.Semi, "';'")
    if oscan.lex == oscan.Lex.IMPORT:
        parse_import()              # import занято
    decl_seq()                      # последовательность объявлений
    if oscan.lex == oscan.Lex.BEGIN:
        oscan.next_lex()
        stat_seq()                  # последовательность операторов
    check(oscan.Lex.END, "END")
    check(oscan.Lex.Name, "имя модуля")
    check(oscan.Lex.Dot, "'.'")


def parse_import():
    check(oscan.Lex.IMPORT, "IMPORT")
    check(oscan.Lex.Name, "имя модуля")
    while oscan.lex == oscan.Lex.Comma:
        oscan.next_lex()
        check(oscan.Lex.Name, "имя модуля")
    check(oscan.Lex.Semi, "';'")


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


def stat_seq():
    statement()
    while oscan.lex == oscan.Lex.Semi:
        oscan.next_lex()
        statement()


def term():         # слагаемое
    factor()        # множитель
    while oscan.lex in [oscan.Lex.Mult, oscan.Lex.DIV, oscan.Lex.MOD]:
        oscan.next_lex()
        factor()    # множитель

# ПростоеВыраж [Отношение ПростоеВыраж]
def expression()->OType:
    t = simple_expr()
    if oscan.lex in [oscan.Lex.EQ, oscan.Lex.NE, oscan.Lex.GT, oscan.Lex.GE, oscan.Lex.LT, oscan.Lex.LE]:
        if t != OType.Int:
            error("несоответствие типу операнда")
        oscan.next_lex()
        t = simple_expr()
        if t != OType.Int:
            expected("выражение целого типа")
        t = OType.Bool
        
# ["+"|"-"] Слагаемое {ОперСлож Слагаемое}
def simple_expr()->OType:
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        oscan.next_lex()
        t = term()
        if t != OType.Int:
            expected("выражение целого типа")
    else:
        t = term()
    if oscan.lex in [oscan.Lex.Plus, oscan.Lex.Minus]:
        if t != OType.Int:
            error("Несоответствие операции типу операнда")
        # ToDo
