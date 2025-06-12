from os.path import exists


fn loadFile(path: String) -> Optional[List[UInt8]]:
    if not exists(path):
        return

    try:
        with open(path, "r") as f:
            var contentArray: List[UInt8] = []
            var contents: String = f.read()

            for char in contents.codepoint_slices():
                contentArray.append(ord(char))

            return contentArray
    except e:
        print("Could not load specified file.", e)

    return


fn saveFile(file: List[UInt8]):
    try:
        with open("test.txt", "w") as f:
            f.write(asciiToString(file))
    except e:
        print("Unable to save file.")


fn asciiToString(asciiArr: List[UInt8]) -> String:
    var text: String = ""

    for ascii in asciiArr:
        text += chr(Int(ascii))

    return text
