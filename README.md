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

Simply run `make run/{VERSION}/{PLATFORM}/{ROLE}`, where:

 - `{VERSION}` is one of `1e`, `2e`, `3e`, `4e-2002`, or `4e-2014`
 - `{ROLE}` is one of
    + `standalone`: A self-contained single-node workstation install
      that boots from local media.
    + `terminal`: A workstation that boots from the network (ideally
      these would be entirely diskless, but some of them need a local
      bootloader or kernel)
    + `cpuserver`: A headless server that a terminal can run do things
      on.
    + `fileserver`: A headless server that does not expose its CPU to
      the network, but serves as the storage for all connected CPU
      servers and terminals (until 4e 2007 or so, the fileserver
      kernel was separate from the normal kernel).
 - `{PLATFORM}` is a `objtype-subtype` pair that supports the
   `{VERSION}` and `{ROLE}` you want, from the version matrices below.

## Version matrices

Legend:
 - ✅ Working
 - 🚧 In-progress
 - ❌ Not-yet implemented
 - ⛔ Unlikely to ever be implemented (but theoretically possible)
 - (no icon) Not possible to implement (i.e. that version on that
   platform officially didn't support that role)
 - ❔ I don't think this is possible to implement, but I'm not 100%
   sure

### `1e` (1st Edition, 2nd Release, 1993-01-03)

|                                  | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes                                                 |
|----------------------------------|--------------|------------|-------------|--------------|-------------------------------------------------------|
| `386-pc` (i386/i486)             | 🚧           | ❌         | ❌          |              | Notable for standalone support                        |
| `68020-gnot` (AT&T Gnot)         | ❔           | ⛔         | ⛔          |              | Hardware never released outside AT&T                  |
| `68020-next` (NeXTstation)       | ❔           | ❌         | ❌          |              | "Previous" emulator                                   |
| `hobbit-hobbit` (AT&T Hobbit)    | ❔           | ⛔         | ⛔          |              | Hardware quickly discontinued                         |
| `mips-6280` (MIPS 6280)          |              |            |             | ❌           |                                                       |
| `mips-indigo` (SGI Indigo)       | ❔           | ❌         | ❌          |              | Added in 2nd Release; not in any docs, just in source |
| `mips-magnum` (MIPS Magnum 3000) | ❔           | ❌         | ❌          | ❌           | MAME (Qemu will not work)                             |
| `mips-power` (SGI Power Series)  |              |            | ❌          | ❌           | Nongraphical, so no standalone/terminal               |
| `sparc-ss` (SPARCstation)        | ❔           | ❌         | ❌          | ❌           | MAME or TME (Qemu will not work)                      |

 - `run/1e/386-pc/standalone`:
   1. First the bootloader will prompt you where to load the kernel
      from (`boot from[default==fd!0!9dos]:`).  Just hit "enter", the
      default is correct.
   2. Then the kernel will prompt where to load the root filesystem
      from (`root is from (local, il, tcp)[local!#f/fd0disk]:`).  I
      just hit "enter" hoping that the default is correct, but I get
      hangs, so IDK.
   3. Then it will prompt for a username and password; choose any
      username you like, and it will believe any password.

### `2e` (2nd Edition, 1995-04-05)

|                                    | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes |
|------------------------------------|--------------|------------|-------------|--------------|-------|
| `386-pc` (i386/i486/Pentium)       | ❌           | ❌         | ❌          | ❌           |       |
| `68020-gnot` (AT&T Gnot)           | ❔           | ❌         | ❌          |              |       |
| `68020-next` (NeXTstation)         | ❔           | ❌         | ❌          |              |       |
| `mips-6280` (MIPS 6280)            |              |            |             | ❌           |       |
| `mips-chm` (SGI Challenge M)       | ❔           | ❌         | ❌          |              |       |
| `mips-indigo3k` (SGI Indigo R3000) | ❔           | ❌         | ❌          |              |       |
| `mips-indigo4k` (SGI Indigo R4000) | ❔           | ❌         | ❌          |              |       |
| `mips-magnum` (MIPS Magnum)        | ❔           | ❌         | ❌          | ❌           |       |
| `mips-power` (SGI Power Series)    | ❔           | ❌         | ❌          | ❌           |       |
| `sparc-ss` (SPARCstation)          | ❔           | ❌         | ❌          | ❌           |       |
| `sparc-ss10` (SPARCstation-10)     | ❔           | ❌         | ❌          |              |       |

### `3e` (2rd Edition; 1st Release=2000-06-07, 5th Release=2001-03-28)

|                                                                   | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes                 |
|-------------------------------------------------------------------|--------------|------------|-------------|--------------|-----------------------|
| `386-pc` (i386/i486/Pentium)                                      | ❌           | ❌         | ❌          | ❌           | fileserver is PC-only |
| `alpha-alphapc` (Alpha PC 164)                                    | ❔           | ❌         | ❌          |              |                       |
| `arm-bitsy` (Compaq Ipaq (ARM), added in 5th Release, 2001-03-28) | ❌           | ❌         | ❌          |              |                       |
| `mips-carrera` (Carrera MIPS PC)                                  | ❔           | ❌         | ❌          |              |                       |
| `mips-ch` (SGI Challenge, dropped in 2nd Release, 2000-06-12)     | ❔           | ❌         | ❌          |              |                       |
| `power-mpc` (AT&T Viaduct MPC8500)                                | ❔           | ❌         | ❌          |              |                       |

### `4e-2002` (4th Edition, 1st Release, 2002-04-27)

|                            | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes                                   |
|----------------------------|--------------|------------|-------------|--------------|-----------------------------------------|
| `386-pc`                   | ❌           | ❌         | ❌          | ❌           | fileserver was PC-only until 2007 or so |
| `alpha-alphapc` (Alpha PC) | ❌           | ❌         | ❌          |              | Dropped 2012-09-20                      |
| `arm-bitsy` (Compaq Ipaq)  | ❌           | ❌         | ❌          |              | Dropped 2013-01-31                      |
| `power-mtx`                | ❌           | ❌         | ❌          |              |                                         |

### `4e-2014` (4th Edition, Final (2500ish) Release, 2014-09-17)

|                                        | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes             |
|----------------------------------------|--------------|------------|-------------|--------------|-------------------|
| `386-pc`                               | ✅           | ❌         | ❌          | ❌           |                   |
| `386-pcboot`                           | ❌           | ❌         | ❌          | ❌           | Added 2012-05-12  |
| `arm-bcm` (bcm2825; e.g. Raspberry Pi) | ❌           | ❌         | ❌          | ❌           | Added 2013-02-26  |
| `arm-kw` (Marvell Kirkwood)            | ❌           | ❌         | ❌          | ❌           | Added 2009-11-14  |
| `arm-omap`                             | ❌           | ❌         | ❌          | ❌           | Added 2010-04-23  |
| `arm-teg2` (Tegra 2)                   | ❌           | ❌         | ❌          | ❌           | Added 2012-025-02 |
| `mips-rb` (rb450g)                     | ❌           | ❌         | ❌          | ❌           | Added 2013-07-24  |
| `power-mtx`                            | ❌           | ❌         | ❌          | ❌           |                   |
| `power-ppc`                            | ❌           | ❌         | ❌          | ❌           | Added 2003-07-29  |

 - `run/4e-2014/386-pc/standalone`:
   1. First press "2" then "enter" to boot from the CD
   2. Then you have to hit "enter" a bunch of times to accept
      defaults.
