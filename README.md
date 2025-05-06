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

|                                                         | `standalone` | `terminal` | `cpuserver` | `fileserver` | Notes                            |
|---------------------------------------------------------|--------------|------------|-------------|--------------|----------------------------------|
| `1e` (1st Edition, 2nd Release, 1993-01-03)             |              |            |             |              |                                  |
| - `gnot` (AT&T Gnot)                                    | ⛔           | ⛔         | ⛔          | ⛔           | Never released outside AT&T      |
| - `hobbit` (AT&T Hobbit)                                | ⛔           | ⛔         | ⛔          | ⛔           | Not commercially successful      |
| - `indigo` (SGI Indigo)                                 | ⛔           | ❌         | ❌          | ⛔           | Unmentioned in any docs          |
| - `power` (SGI Power Series)                            | ⛔           | ⛔         | ❌          | ❌           | -                                |
| - `magnum` (MIPS Magnum 3000)                           | ⛔           | ❌         | ❌          | ❌           | MAME (Qemu will not work)        |
| - `6280` (MIPS 6280)                                    | ⛔           | ⛔         | ⛔          | ❌           | -                                |
| - `next` (NeXTstation)                                  | ⛔           | ❌         | ❌          | ⛔           | "Previous" emulator              |
| - `ss` (SPARCstation)                                   | ⛔           | ❌         | ❌          | ❌           | MAME or TME (Qemu will not work) |
| - `pc` (i386/i486)                                      | 🚧           | ❌         | ❌          | ⛔           | Notable for standalone support   |
|---------------------------------------------------------|--------------|------------|-------------|--------------|----------------------------------|
| `2e`                                                    | ❌           | ❌         | ❌          | ❌           |                                  |
| `3e`                                                    | ❌           | ❌         | ❌          | ❌           |                                  |
|---------------------------------------------------------|--------------|------------|-------------|--------------|----------------------------------|
| `4e` (4th edition, Final (2500ish) Release, 2014-09-17) |              |            |             |              |                                  |
| - `pc`                                                  | ✅           | ❌         | ❌          | ❌           |                                  |
	
Legend:
 - ✅ Working
 - 🚧 In-progress
 - ❌ Not-yet implemented
 - ⛔ Unlikely to ever be implemented

Specific usage:

 - `1e/pc/standalone`:
   1. First the bootloader will prompt you where to load the kernel
      from (`boot from[default==fd!0!9dos]:`).  Just hit "enter", the
      default is correct.
   2. Then the kernel will prompt where to load the root filesystem
      from (`root is from (local, il, tcp)[local!#f/fd0disk]:`).  I
      just hit "enter" hoping that the default is correct, but I get
      hangs, so IDK.
   3. Then it will prompt for a username and password; choose any
      username you like, and it will believe any password.

 - `4e/pc/standalone`:
   1. First press "2" then "enter" to boot from the CD
   2. Then you have to hit "enter" a bunch of times to accept
      defaults.
