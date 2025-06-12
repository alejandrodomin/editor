from sys.ffi import UnsafePointer, external_call

alias c_tclag_t = UInt32
alias c_cc_t = UInt8  # equivalent of char


struct Termios:
    var iflag: c_tclag_t
    var oflag: c_tclag_t
    var cflag: c_tclag_t
    var lflag: c_tclag_t
    var line: c_cc_t
    var cc: c_cc_t

    fn __init__(
        out self,
        iflag: c_tclag_t = 0,
        oflag: c_tclag_t = 0,
        cflag: c_tclag_t = 0,
        lflag: c_tclag_t = 0,
        line: c_cc_t = 0,
        cc: c_cc_t = 0,
    ):
        self.iflag = iflag
        self.oflag = oflag
        self.cflag = cflag
        self.lflag = lflag
        self.line = line
        self.cc = cc

    fn __copyinit__(original: Termios) -> Termios:
        return Termios(
            original.iflag,
            original.oflag,
            original.cflag,
            original.lflag,
            original.line,
            original.cc,
        )

    fn __str__(self) -> String:
        return (
            "iflag "
            + String(self.iflag)
            + ", oflag "
            + String(self.oflag)
            + ", cflag "
            + String(self.cflag)
            + ", lflag "
            + String(self.lflag)
            + ", line "
            + String(self.line)
            + ", cc "
            + String(self.cc)
        )


# void set_raw_mode(int enable) {
#    static struct termios oldt, newt;
#
#    if (enable) {
#        tcgetattr(STDIN_FILENO, &oldt);        // save current settings
#        newt = oldt;
#        newt.c_lflag &= ~(ICANON | ECHO);      // disable buffering and echo
#        newt.c_cc[VMIN] = 0;                   // return immediately if no input
#        newt.c_cc[VTIME] = 0;                  // no timeout
#        tcsetattr(STDIN_FILENO, TCSANOW, &newt);
#    } else {
#        tcsetattr(STDIN_FILENO, TCSANOW, &oldt); // restore old settings
#    }
# }


fn get_termios_settings(fd: Int, tPtr: UnsafePointer[Termios]):
    _ = external_call["tcgetattr", Int, Int, UnsafePointer[Termios]](fd, tPtr)
