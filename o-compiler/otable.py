from enum import Enum
from oerror import *


class OType(Enum):
    TypeNone = 0
    Int = 1
    Bool = 2


class Category(Enum):
    Var = 1
    Const = 2
    StandartProc = 3
    catType = 4
    Module = 5
    Guard = 6
    Unknown = 10


class Function(Enum):
    FuncNone = 0
    ABS = 1
    MAX = 2
    MIN = 3
    DEC = 4
    ODD = 5
    HALT = 6
    INC = 7
    InOpen = 8
    InInt = 9
    OutInt = 10
    OutLn = 11


class ProgramObject:
    def __init__(self):
        self.name = ""  # ключ поиска
        self.category = Category.Unknown  # категория имени
        self.type = OType.TypeNone  # тип
        self.value = None  # значение


# таблица имен, точнее стек =)
program_objects = []
current_objet = ProgramObject()
current_objet_index = 0


def enter(name: str, category: Category, type: OType, value):
    global program_objects
    program_object = ProgramObject()
    program_object.name = name
    program_object.category = category
    program_object.type = type
    program_object.value = value
    program_objects.append(program_object)


def new_name(name: str, category: Category) -> ProgramObject:
    global program_objects
    index = -1
    while program_objects[index].category != Category.Guard and \
            program_objects[index].name != name:
        index -= 1
    if program_objects[index].category == Category.Guard:
        obj = ProgramObject()
        obj.name = name
        obj.category = category
        obj.value = 0
        program_objects.append(obj)
        return obj
    else:
        error("повтороное объявление имени")


def find(name: str) -> ProgramObject:
    global program_objects
    index = -1
    while program_objects[index].name != name:
        index -= 1
        if index == -(len(program_objects) + 1):
            error("Необъявленное имя")
    return program_objects[index]


def open_scope():
    enter("", Category.Guard, OType.TypeNone, 0)


def close_scope():
    global program_objects
    while program_objects[-1].category != Category.Guard:
        program_objects.pop()


def first_var() -> ProgramObject:
    global current_objet
    global current_objet_index
    current_objet = program_objects[-1]
    current_objet_index = -1
    return next_var()


def next_var() -> ProgramObject:
    global current_objet
    global current_objet_index
    while current_objet != program_objects[0] and current_objet.category != Category.Var:
        current_objet = program_objects[current_objet_index - 1]
        current_objet_index -= 1
    if current_objet == program_objects[0]:
        return None
    else:
        result = current_objet
        current_objet = program_objects[current_objet_index - 1]
        current_objet_index -= 1
    return result
