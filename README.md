# 1e

I'm currently trying to get the stand-alone i386/i486 PC version to
run.

Ports:

| Name                                                        | Viable   | Flags         | Impl Notes                                                                                                     | Emulator notes                                                                                 |
|-------------------------------------------------------------+----------+---------------+----------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------|
| 68040-based NeXTstation ("and on no other NeXT machine")    |          |               | 2-bit-per-pixel                                                                                                | https://sourceforge.net/projects/previous/                                                     |
| MIPS Magnum 3000 ("the system will run on only that model") | Maybe    |               | 1-bit b/w, or 8-bit color                                                                                      | Qemu only supports down to the 4000.  https://wiki.mamedev.org/index.php/Driver:MIPS           |
| SGI Power Series, 4D series, with IO3 boards                | No       | non-graphical | CPU-server only; non-graphical                                                                                 |                                                                                                |
| Sun (1989-04) 4/60 (A.K.A. SPARCstation 1)                  |          | untested      | pizzabox                                                                                                       |                                                                                                |
| Sun (1990-05) 4/20 (A.K.A. SPARCstation SLC)                |          |               | integrated                                                                                                     |                                                                                                |
| Sun (1990-05) 4/65 (A.K.A. SPARCstation 1+)                 |          | untested      | pizzabox                                                                                                       |                                                                                                |
| Sun (1990-07) 4/40 (A.K.A. SPARCstation IPC)                |          | untested      | lunchbox                                                                                                       |                                                                                                |
| Sun (1990-11) 4/75 (A.K.A. SPARCstation 2)                  | Maybe    |               | pizzabox                                                                                                       | Qemu only supports down to 4; https://computernewb.com/wiki/Boot_SPARCStation_1_in_MAME or TME |
| Sun (1991-07) 4/25 (A.K.A. SPARCstation ELC)                |          | untested      | integrated                                                                                                     |                                                                                                |
| Sun (1991-07) 4/50 (A.K.A. SPARCstation IPX)                |          | untested      | lunchbox                                                                                                       |                                                                                                |
| i386/i486                                                   | Probably |               | Tested on "AT&T Safari", "AT&T 6386", and "Gateway 486".  Monochrome-only.  Stand-alone or with a file-server. |                                                                                                |

The MIPS Magnum 3000 and SPARCstation 2 are the only ones mentioned in
`install.ms`.  `install.ms` seems to indicate that these ports can
either be file-server or terminal; that there is no "stand-alone" mode
for these ports.

[TME]: https://people.csail.mit.edu/fredette/tme/index.html
