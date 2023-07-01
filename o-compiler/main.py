import otext
import opars
import oscan
import ovm
import ogen


def init():
    otext.reset_text("o-code-files/test.o")
    oscan.init_scan()
    ogen.init()

print("O-compiler")
init()
opars.compile_o()
ovm.print_program()
print("================")
ovm.run()