import otext
import opars
import oscan


def init():
    otext.reset_text()
    oscan.init_scan()


print("O-compiler")
init()
opars.compile()