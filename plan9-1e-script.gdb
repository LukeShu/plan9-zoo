# -*- Mode: gdb-script -*-

target remote localhost:1234

# "Patch" b.com:l.s:flush() to not forget to initialize FS and GS
# (this was fixed in 2e).
break *0x8013c
cont
set $fs = $ax
set $gs = $ax
cont
