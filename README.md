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

runproc: 
  0x8000b042
  0x8000b117


text:
  0x800010bc
  0x8003a6ab

bochs: 
 lbreak 0x21d90 # l.s:origin
 lbreak 0x8011d # l.s:lowcore

at freedos prompt:
cs 06c1
ds 00d9
es 00d9
ss 00d9
fs 10b3
gs 1e4b

at l.s:origin (0x21d90)
cs 21c9
ds 21c9
es 21c9
ss 21c9
fs 21c9
gs 1e4b

after mode change:
cs 8000
ds 8000
es 8000
ss 21c9
fs 21c9
gs 1e4b

at b.com prompt:
cs 1000
ds 8000
es 8000
ss 8000
fs 21c9
gs 1e4b
