# Plan 9 Zoo - Run historical versions of Plan 9 from Bell Labs

## Dependencies

Common dependencies:
 - GNU Make
 - `sha256sum` (as from GNU coreutils)
 - `grep -E`
 - `curl`
 - `bsdtar`
 - `qemu-system-i386`

Weird dependencies for plan9-1e:
 - GNU Bash (`bash`)
 - GNU Debugger (`gdb`)
 - basic utilities (as from GNU coreutils):
	+ `mkdir`
	+ `rmdir`
	+ `mv`
	+ `cp`
	+ `rm`
 - util-linux:
    + `losetup`
	+ `mount`
 - `sudo`

## Usage

Simply run `make run/{VERSION}/{PLATFORM}/{ROLE}`, where `{VERSION}`
and `{PLATFORM}` are in the left column, and `{ROLE}` is in the top
row:

|                                                                                | `standalone`         | `terminal`           | `cpuserver`          | `fileserver`              | Notes                                   |
|--------------------------------------------------------------------------------|----------------------|----------------------|----------------------|---------------------------|-----------------------------------------|
| `1e` (1st Edition, 2nd Release, 1993-01-03)                                    |                      |                      |                      |                           |                                         |
| - `386-pc` (i386/i486)                                                         | 🚧                   | ❌                   | ❌                   | no `sys/src/fs/pc/`       | Notable for standalone support          |
| - `68020-gnot` (AT&T Gnot)                                                     | ❓                   | ⛔                   | ⛔                   | no `sys/src/fs/gnot/`     | Hardware never released outside AT&T    |
| - `68020-next` (NeXTstation)                                                   | ❓                   | ❌                   | ❌                   | no `sys/src/fs/next/`     | "Previous" emulator                     |
| - `hobbit-hobbit` (AT&T Hobbit)                                                | ❓                   | ⛔                   | ⛔                   | no `sys/src/fs/hobbit/`   | Hardware quickly discontinued           |
| - `mips-6280` (MIPS 6280)                                                      | no `sys/src/9/6280/` | no `sys/src/9/6280/` | no `sys/src/9/6280/` | ❌                        | -                                       |
| - `mips-indigo` (SGI Indigo, added in 2nd Release)                             | ❓                   | ❌                   | ❌                   | no `sys/src/fs/indigo/`   | Not in any docs, just in source         |
| - `mips-magnum` (MIPS Magnum 3000)                                             | ❓                   | ❌                   | ❌                   | ❌                        | MAME (Qemu will not work)               |
| - `mips-power` (SGI Power Series)                                              | nongraphic           | nongraphic           | ❌                   | ❌                        | -                                       |
| - `sparc-ss` (SPARCstation)                                                    | ❓                   | ❌                   | ❌                   | ❌                        | MAME or TME (Qemu will not work)        |
|--------------------------------------------------------------------------------|----------------------|----------------------|----------------------|---------------------------|-----------------------------------------|
| `2e` (2nd Edition, 1995-04-05)                                                 |                      |                      |                      |                           |                                         |
| - `386-pc` (i386/i486/Pentium)                                                 | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `68020-gnot` (AT&T Gnot)                                                     | ❓                   | ❌                   | ❌                   | no `sys/src/fs/gnot/`     |                                         |
| - `68020-next` (NeXTstation)                                                   | ❓                   | ❌                   | ❌                   | no `sys/src/fs/next/`     |                                         |
| - `mips-6280` (MIPS 6280)                                                      | no `sys/src/9/6280/` | no `sys/src/9/6280/` | no `sys/src/9/6280/` | ❌                        |                                         |
| - `mips-chm` (SGI Challenge M)                                                 | ❓                   | ❌                   | ❌                   | no `sys/src/fs/chm/`      |                                         |
| - `mips-indigo3k` (SGI Indigo R3000)                                           | ❓                   | ❌                   | ❌                   | no `sys/src/fs/indigo3k/` |                                         |
| - `mips-indigo4k` (SGI Indigo R4000)                                           | ❓                   | ❌                   | ❌                   | no `sys/src/fs/indigo4k/` |                                         |
| - `mips-magnum` (MIPS Magnum)                                                  | ❓                   | ❌                   | ❌                   | ❌                        |                                         |
| - `mips-power` (SGI Power Series)                                              | ❓                   | ❌                   | ❌                   | ❌                        |                                         |
| - `sparc-ss10` (SPARCstation-10)                                               | ❓                   | ❌                   | ❌                   | no `sys/src/fs/ss10/`     |                                         |
| - `sparc-ss` (SPARCstation)                                                    | ❓                   | ❌                   | ❌                   | ❌                        |                                         |
|--------------------------------------------------------------------------------|----------------------|----------------------|----------------------|---------------------------|-----------------------------------------|
| `3e` (2rd Edition; 1st Release=2000-06-07, 5th Release=2001-03-28)             |                      |                      |                      |                           |                                         |
| - `386-pc` (i386/i486/Pentium)                                                 | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `alpha-alphapc` (Alpha PC 164)                                               | ❓                   | ❌                   | ❌                   | IBM PC only               |                                         |
| - `arm-bitsy` (Compaq Ipaq (ARM), added in 5th Release, 2001-03-28)            | ❌                   | ❌                   | ❌                   | IBM PC only               |                                         |
| - `mips-carrera` (Carrera MIPS PC)                                             | ❓                   | ❌                   | ❌                   | IBM PC only               |                                         |
| - `mips-ch` (SGI Challenge, dropped in 2nd Release, 2000-06-12)                | ❓                   | ❌                   | ❌                   | IBM PC only               |                                         |
| - `power-mpc` (AT&T Viaduct MPC8500)                                           | ❓                   | ❌                   | ❌                   | IBM PC only               |                                         |
|--------------------------------------------------------------------------------|----------------------|----------------------|----------------------|---------------------------|-----------------------------------------|
| `4e` (4th Edition; 1st Release=2002-04-27, Final (2500ish) Release=2014-09-17) |                      |                      |                      |                           |                                         |
| - `386-pc` (all releases)                                                      | ✅                   | ❌                   | ❌                   | ❌                        | fileserver was PC-only until 2007 or so |
| - `386-pcboot` (added 2012-05-12)                                              | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `alpha-alphapc` (Alpha PC, dropped 2012-09-20)                               | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `arm-bcm` (bcm2825 (e.g. Raspberry Pi), added 2013-02-26)                    | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `arm-bitsy` (Compaq Ipaq, dropped 2013-01-31)                                | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `arm-kw` (Marvell Kirkwood, added 2009-11-14)                                | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `arm-omap` (added 2010-04-23)                                                | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `arm-teg2` (Tegra 2, added 2012-025-02)                                      | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `mips-rb` (rb450g, added 2013-07-24)                                         | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `power-mtx` (all releases)                                                   | ❌                   | ❌                   | ❌                   | ❌                        |                                         |
| - `power-ppc` (added 2003-07-29)                                               | ❌                   | ❌                   | ❌                   | ❌                        |                                         |

Legend:
 - ✅ Working
 - 🚧 In-progress
 - ❌ Not-yet implemented
 - ⛔ Unlikely to ever be implemented
 - ❓ I don't think this combination exists
 - "text" Why this combination does not exist

Specific usage:

 - `1e/386-pc/standalone`:
   1. First the bootloader will prompt you where to load the kernel
      from (`boot from[default==fd!0!9dos]:`).  Just hit "enter", the
      default is correct.
   2. Then the kernel will prompt where to load the root filesystem
      from (`root is from (local, il, tcp)[local!#f/fd0disk]:`).  I
      just hit "enter" hoping that the default is correct, but I get
      hangs, so IDK.
   3. Then it will prompt for a username and password; choose any
      username you like, and it will believe any password.

 - `4e/386-pc/standalone`:
   1. First press "2" then "enter" to boot from the CD
   2. Then you have to hit "enter" a bunch of times to accept
      defaults.
