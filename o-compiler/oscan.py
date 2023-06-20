import otext
from enum import Enum
from oerror import *


class Lex(Enum):
    lexNone = 1
    Name = 2
    Num = 3
    MODULE = 4
    IMPORT = 5
    BEGIN = 6
    END = 7
    CONST = 8
    VAR = 9
    WHILE = 10
    DO = 11
    IF = 12
    THEN = 13
    ELSIF = 14
    ELSE = 15
    Mult = 16
    DIV = 17
    MOD = 18
    Plus = 19
    Minus = 20
    EQ = 21
    NE = 22
    LT = 23
    LE = 24
    GT = 25
    GE = 26
    Dot = 27
    Comma = 28
    Colon = 29
    Semi = 30
    Ass = 31
    LPar = 32
    RPar = 33
    EOT = 34


keywords = {
    "ARRAY": Lex.lexNone,
    "BY": Lex.lexNone,
    "BEGIN": Lex.BEGIN,
    "CASE": Lex.lexNone,
    "CONST": Lex.CONST,
    "DIV": Lex.DIV,
    "DO": Lex.DO,
    "ELSE": Lex.ELSE,
    "ELSIF": Lex.ELSIF,
    "END": Lex.END,
    "EXIT": Lex.lexNone,
    "FOR": Lex.lexNone,
    "IF": Lex.IF,
    "IMPORT": Lex.IMPORT,
    "IN": Lex.lexNone,
    "IS": Lex.lexNone,
    "LOOP": Lex.lexNone,
    "MOD": Lex.MOD,
    "MODULE": Lex.MODULE,
    "NIL": Lex.lexNone,
    "OF": Lex.lexNone,
    "OR": Lex.lexNone,
    "POINTER": Lex.lexNone,
    "PROCEDURE": Lex.lexNone,
    "RECORD": Lex.lexNone,
    "REPEAT": Lex.lexNone,
    "RETURN": Lex.lexNone,
    "THEN": Lex.THEN,
    "TO": Lex.lexNone,
    "TYPE": Lex.lexNone,
    "UNTIL": Lex.lexNone,
    "VAR": Lex.VAR,
    "WHILE": Lex.WHILE,
    "WITH": Lex.lexNone
}

lex = Lex.lexNone
name = ""
num = 0 # значение числовых литералов
lex_pos = 0

MAX_NAME_LEN = 31
MAX_INT = 32000


def init_scan():
    global lex
    global name
    global num
    global lex_pos
    lex = Lex.lexNone
    name = ""
    num = 0  # значение числовых литералов
    lex_pos = 0
    next_lex()


def next_lex():
    global lex
    global lex_pos
    #print("next_lex()")
    while otext.ch in [otext.CH_SPACE, otext.CH_TAB, otext.CH_EOL]:
        otext.next_ch()
    lex_pos = otext.pos
    if otext.ch.isalpha():
        ident()
    elif otext.ch.isnumeric():
        number()
    elif otext.ch == ";":
        otext.next_ch()
        lex = Lex.Semi
    elif otext.ch == ".":
        otext.next_ch()
        lex = Lex.Dot
    elif otext.ch == ",":
        otext.next_ch()
        lex = Lex.Comma
    elif otext.ch == ":":
        otext.next_ch()
        if otext.ch == "=":
            otext.next_ch()
            lex = Lex.Ass
        else:
            lex = Lex.Colon
    elif otext.ch == "=":
        otext.next_ch()
        lex = Lex.EQ
    elif otext.ch == "#":
        otext.next_ch()
        lex = Lex.NE
    elif otext.ch == "<":
        otext.next_ch()
        if otext.ch == "=":
            otext.next_ch()
            lex = Lex.LE
        else:
            lex = Lex.LT
    elif otext.ch == ">":
        otext.next_ch()
        if otext.ch == "=":
            otext.next_ch()
            lex = Lex.GE
        else:
            lex = Lex.GT
    elif otext.ch == "(":
        otext.next_ch()
        if otext.ch == "*":
            comment();
            next_lex()
        else:
            lex = Lex.LPar
    elif otext.ch == ")":
        otext.next_ch()
        lex = Lex.RPar
    elif otext.ch == "+":
        otext.next_ch()
        lex = Lex.Plus
    elif otext.ch == "-":
        otext.next_ch()
        lex = Lex.Minus
    elif otext.ch == "*":
        otext.next_ch()
        lex = Lex.Mult
    elif otext.ch == otext.CH_EOT:
        lex = Lex.EOT
    else:
        error("недопустимый символ")


def ident():
    global name
    global keywords
    global lex
    #print("ident()")
    name = ""
    # по инварианту первый символ и так буква
    while otext.ch.isalpha() or otext.ch.isnumeric():
        if len(name) < MAX_NAME_LEN:
            name += otext.ch
        else:
            error("слишком длинное имя")
        otext.next_ch()
    if name in keywords:
        lex = keywords[name]
    else:
        lex = Lex.Name


def number():
    global lex
    global num
    #print("number")
    d = 0
    lex = Lex.Num
    num = 0
    while otext.ch.isnumeric():
        d = ord(otext.ch) - ord("0");
        if (MAX_INT - d) // 10 >= num:
            num = 10 * num + d
        else:
            error("слишком большое число")
        otext.next_ch()


def comment():
    global lex
    global lex_pos
    #print("comment()")
    otext.next_ch()
    end_flag = False
    while not end_flag:
        while otext.ch != "*" and otext.ch != otext.CH_EOT:
            if otext.ch == "(":
                otext.next_ch()
                if otext.ch == "*":
                    comment()
            else:
                otext.next_ch()
        if otext.ch == "*":
            otext.next_ch()
        if otext.ch in [")", otext.CH_EOT]:
            end_flag = True
    if otext.ch == ")":
        otext.next_ch()
    else:
        lex_pos = otext.pos
        error("Не закончен комментарий")
