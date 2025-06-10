import sys
from os.path import exists

var UP_ARROW = "\x1b[A"
var DOWN_ARROW = "\x1b[B"
var RIGHT_ARROW = "\x1b[C"
var LEFT_ARROW = "\x1b[D"


fn main():
    file: List[UInt8] = loadFile("test.txt").or_else([])

    while True:
        print("\033[2J\033[H")  # Clear screen

        try:
            input_str = input(">")
            if input_str == "quit":
                break
            elif input_str == "save":
                saveFile(file)

            for char in input_str.codepoint_slices():
                file.append(ord(char))
            file.append(ord("\n"))
        except e:
            pass


fn loadFile(path: String) -> Optional[List[UInt8]]:
    if not exists(path):
        return

    try:
        with open(path, "r") as f:
            var contentArray: List[UInt8]
            var contents: String = f.read()

            for char in contents.codepoint_slices():
                contentArray.append(ord(char))

            return contentArray
    except e:
        print("Could not load specified file.", e)


fn saveFile(file: List[UInt8]):
    try:
        var text: String = ""

        for ascii in file:
            text += chr(Int(ascii))

        with open("test.txt", "w") as f:
            f.write(text)
    except e:
        print("Unable to save file.")
