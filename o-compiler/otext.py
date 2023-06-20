CH_SPACE = " "
CH_TAB = chr(9)
CH_EOL = chr(10)
CH_EOT = chr(0)

textdata = ""
ch = ""
line = 0
pos = -1


def next_ch():
    global ch
    global textdata
    global line
    global pos
    global CH_EOL
    global CH_EOT

    pos += 1
    if pos == len(textdata):
        ch = CH_EOT
        return
    ch = textdata[pos]
    if ch == CH_EOL:
        line += 1


def reset_text(filename):
    global textdata
    f = open(filename, "r")
    textdata = f.read()
    f.close()
    next_ch()

