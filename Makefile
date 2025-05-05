# Configure Make itself ##############################################

.DEFAULT_GOAL = run-1e
.DELETE_ON_ERROR:
.NOTINTERMEDIATE:
.SHELLFLAGS += -e -o pipefail

# Utilities ##########################################################

.PHONY: FORCE

# Download rules #####################################################

p9f_mirror = https://ftp.osuosl.org/pub/plan9/history
#p9f_mirror = https://plan9.io/plan9/download/history
#p9f_mirror = https://9p.io/plan9/download/history
plan9-sha256sums.txt:
	curl -L $(p9f_mirror)/sha256sum.txt >$@
plan9-%.bz2: plan9-sha256sums.txt FORCE
	(grep $@ $< | sha256sum --check) || (curl -L $(p9f_mirror)/$@ >$@ && (grep $@ $< | sha256sum --check))

fd13_mirror = https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.3/official
FD13-verify.txt:
	curl -L https://freedos.org/download/verify.txt >$@
FD13%.zip: FD13-verify.txt FORCE
	(grep -E "^[0-9a-f]{64}\s+$@" $< | sha256sum --check) || (curl -L $(fd13_mirror)/$@ >$@ && (grep -E "^[0-9a-f]{64}\s+$@" $< | sha256sum --check))

# 1e #################################################################

FD13-LiteUSB/FD13LITE.img: FD13-LiteUSB/%: FD13-LiteUSB.zip
	mkdir -p $(@D)
	bsdtar xfO $< $* >$@

plan9-1e-fdboot.img: FD13-LiteUSB/FD13LITE.img plan9-1e-fdauto.bat plan9-1e-fdconfig.sys
	cp $< $@.tmp
	mkdir -p $@.d
	set -x; { \
	    cleanup=(); \
	    trap 'for cmd in "$${cleanup[@]}"; do eval "$$cmd"; done' EXIT; \
	    \
	    dev=$$(sudo losetup --find --show --partscan $@.tmp); \
	    cleanup+=("sudo losetup --detach $$dev"); \
	    \
	    sudo mount -o umask=0000 "$${dev}p1" $@.d; \
	    cleanup+=('sudo umount $@.d'); \
	    \
	    cp plan9-1e-fdauto.bat $@.d/fdauto.bat; \
	    cp plan9-1e-fdconfig.sys $@.d/fdconfig.sys; \
	    rm $@.d/setup.bat; \
	}
	rmdir $@.d
	mv $@.tmp $@

plan9-1e/sys/lib/pcdisk: plan9-1e.tar.bz2
	mkdir -p $(@D)
	bsdtar xfO $< $@ >$@

#qemu_extra = -S -s
#qemu_extra = -icount shift=auto,rr=record,rrfile=replay.bin,rrsnapshot=boot_s
#qemu_extra = -icount shift=auto,rr=replay,rrfile=replay.bin -S -s
#qemu_extra = -rtc clock=vm -icount shift=1,align=off
#qemu_extra = -d in_asm -D in_asm.log
#qemu_extra = -d in_asm,exec,cpu,nochain -D in_asm-3.log
#qemu_extra = -d int -D int-1.log
#qemu_extra = -d int -D int-2.log -S -s
#qemu_extra = -serial stdio
#qemu_extra = -d int,mmu -D int-mmu-1.log -S -s
#qemu_extra = -d mmu -D mmu-1.log
#qemu_extra = -m 1G
#qemu_extra = -d in_asm,int -D int-asm-1.log -S -s

qemu_extra += -S # Do not start CPU at startup
qemu_extra += -gdb tcp::1234
# qemu_extra += -action reboot=shutdown   # reset|shutdown [default=reset]
# qemu_extra += -action shutdown=pause    # poweroff|pause [default=poweroff]
# qemu_extra += -action panic=pause       # pause|shutdown|exit-failure|none [default=shutdown]
# qemu_extra += -action watchdog=debug    # reset|shutdown|poweroff|inject-nmi|pause|debug|none [default=reset]

drive/cdrom = index=2,media=cdrom
drive/hda   = index=0,media=disk
drive/hdb   = index=1,media=disk
drive/hdc   = index=2,media=disk
drive/hdd   = index=3,media=disk
drive/fda   = index=0,if=floppy
drive/fdb   = index=1,if=floppy

run-1e: plan9-1e-fdboot.img
run-1e: plan9-1e/sys/lib/pcdisk
	qemu-system-i386 $(qemu_extra) \
	  -cpu 486 \
	  -drive $(drive/hda),format=raw,readonly=off,file=plan9-1e-fdboot.img \
	  -drive $(drive/fda),format=raw,readonly=on,file=plan9-1e/sys/lib/pcdisk \
	  -boot c

######################################################################

versions = 1e 2e 3e 4e 4e-latest
