# User configuration #################################################

p9f_mirror = https://ftp.osuosl.org/pub/plan9/history
#p9f_mirror = https://plan9.io/plan9/download/history
#p9f_mirror = https://9p.io/plan9/download/history

fd13_mirror = https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.3/official
fd14_mirror = https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.4

qemu_extra += -action reboot=shutdown   # reset|shutdown [default=reset]
#qemu_extra += -action shutdown=pause    # poweroff|pause [default=poweroff]
#qemu_extra += -action panic=pause       # pause|shutdown|exit-failure|none [default=shutdown]
#qemu_extra += -action watchdog=debug    # reset|shutdown|poweroff|inject-nmi|pause|debug|none [default=reset]

# Configure Make itself ##############################################

.DEFAULT_GOAL = run/1e/pc/standalone
.DELETE_ON_ERROR:
.NOTINTERMEDIATE:
SHELL = bash # for the plan9-1e/boot-hdd.img recipe

# Utilities ##########################################################

.PHONY: FORCE

qemu-drive/cdrom = index=2,media=cdrom
qemu-drive/hda   = index=0,media=disk
qemu-drive/hdb   = index=1,media=disk
qemu-drive/hdc   = index=2,media=disk
qemu-drive/hdd   = index=3,media=disk
qemu-drive/fda   = index=0,if=floppy
qemu-drive/fdb   = index=1,if=floppy

# Main ###############################################################

include downloads/dir.mk
include plan9-1e/dir.mk
include plan9-4e/dir.mk
