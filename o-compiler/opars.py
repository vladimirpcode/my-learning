import oscan
import otext

def compile():
    n = 0
    while oscan.lex != oscan.Lex.EOT:
        n += 1
        oscan.next_lex()
        print(oscan.lex)
    print(f"число лексем {n}")

otext.reset_text()
compile()
