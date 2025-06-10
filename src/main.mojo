import sys
from os.path import exists

var UP_ARROW = "\x1b[A"
var DOWN_ARROW = "\x1b[B"
var RIGHT_ARROW = "\x1b[C"
var LEFT_ARROW = "\x1b[D"


def main():
    file: String = loadFile("test.txt")

    while True:
        print("\033[2J\033[H")  # Clear screen

        input_char = input(file)
        if input_char == "quit":
            break
        elif input_char == "save":
            saveFile(file)

        file += input_char + "\n"


def loadFile(path: String) -> String:
    if exists(path):
        with open(path, "r") as f:
            return f.read()

    return ""


def saveFile(file: String):
    with open("test.txt", "w") as f:
        f.write(file)
