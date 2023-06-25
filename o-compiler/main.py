import otext
import opars
import oscan
import ovm
import ogen


def init():
    otext.reset_text("o-code-files/1.o")
    oscan.init_scan()
    ogen.init()

print("O-compiler")
init()
opars.compile_o()
ovm.run()