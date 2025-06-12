from sys.ffi import c_ssize_t, c_size_t, external_call
from memory.owned_pointer import UnsafePointer
from logger import Logger
from termios import Termios, get_termios_settings

var log = Logger()

alias STDIN = 0


fn main():
    var fd: Int = STDIN
    var size: c_size_t = 64

    var buffer: List[UInt8] = [UInt8(0)] * size
    log.debug("Size of buffer:", buffer.capacity)

    var bufP: UnsafePointer[UInt8] = buffer.data

    var count = external_call[
        "read", c_ssize_t, Int, UnsafePointer[UInt8], c_size_t
    ](fd, bufP, size)

    if count > 0:
        log.info("Reading bytes:")
        for i in range(count):
            print(chr(Int(buffer[i])))

    set_raw_mode(True)


fn set_raw_mode(enable: Bool):
    var oldt: Termios = Termios()
    var oldPtr = UnsafePointer(to=oldt)

    if enable:
        get_termios_settings(STDIN, oldPtr)
        log.debug("Old termios settings:", String(oldPtr[]))

        var newt: Termios = oldPtr[]
        # TODO: change setting to allow for real time read
    else:
        pass
