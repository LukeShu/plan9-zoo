# Plan 9 Zoo - Run historical versions of Plan 9 from Bell Labs

Dependencies:
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

Usage:
 - `make plan9-1e/run` (or just `make`)
 - First the bootloader will prompt you where to load the kernel from
   (`boot from[default==fd!0!9dos:`).  Just hit "enter", the default
   is correct.
 - Then the kernel will prompt where to load the root filesystem from
   (`root is from (local, il, tcp)[local!#f/fd0disk]:`).  I just hit
   "enter" hoping that the default is correct, but I get hangs, so
   IDK.
 - Then it will prompt for a username and password; choose any
   username you like, and it will believe any password.
