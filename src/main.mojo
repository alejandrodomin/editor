import sys

var UP_ARROW = "\x1b[A"
var DOWN_ARROW = "\x1b[B"
var RIGHT_ARROW = "\x1b[C"
var LEFT_ARROW = "\x1b[D"


def main():
    file: String = ""

    while True:
        print("\033[2J\033[H")  # Clear screen

        input_char = input(file)
        if input_char == "quit":
            break
        elif input_char == "save":
            saveFile(file)

        file += input_char + "\n"


def saveFile(file: String):
    with open("test.txt", "w") as f:
        f.write(file)
