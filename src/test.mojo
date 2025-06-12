from sys.ffi import c_ssize_t, c_size_t, external_call
from memory.owned_pointer import UnsafePointer
from logger import Logger

var log = Logger()


fn main():
    var fd: Int = 0
    var size: c_size_t = 64

    var buffer: List[UInt8] = [UInt8(0)] * size
    log.info("Size of buffer:", buffer.capacity)

    var bufP: UnsafePointer[UInt8] = buffer.data

    var count = external_call[
        "read", c_ssize_t, Int, UnsafePointer[UInt8], c_size_t
    ](fd, bufP, size)

    if count > 0:
        print("Reading bytes:")
        for i in range(count):
            print(chr(Int(buffer[i])))
