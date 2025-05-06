# -*- Mode: gdb-script -*-

target remote ./1e/386-pc/standalone.sock

# "Patch" b.com:l.s:flush() to not forget to initialize FS and GS
# (this was fixed in 2e).
break *0x8013c
cont
set $fs = $ax
set $gs = $ax
cont
