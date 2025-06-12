import sys
from os.path import exists

from fileio import *

var UP_ARROW = "\x1b[A"
var DOWN_ARROW = "\x1b[B"
var RIGHT_ARROW = "\x1b[C"
var LEFT_ARROW = "\x1b[D"


fn main():
    file: List[UInt8] = loadFile("test.txt").or_else([])

    while True:
        print("\033[2J\033[H")  # Clear screen

        try:
            print(asciiToString(file))
            input_str = input(">")

            if input_str == "quit":
                break
            elif input_str == "save":
                saveFile(file)

            for char in input_str.codepoint_slices():
                if char == UP_ARROW:
                    print("up arrow")
                elif char == DOWN_ARROW:
                    pass
                elif char == RIGHT_ARROW:
                    pass
                elif char == LEFT_ARROW:
                    pass
                else:
                    file.append(ord(char))

            file.append(ord("\n"))
        except e:
            pass


# fn handleCommands(text: String) -> Int:
