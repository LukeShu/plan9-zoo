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

plan9-1e-bootloader.img: FD13-LiteUSB/FD13LITE.img
	cp $< $@.tmp
	mkdir -p $@.d
	set -x; { \
	    cleanup=(); \
	    trap 'for cmd in "$${cleanup[@]}"; do eval "$$cmd"; done' EXIT; \
	    \
	    dev=$$(sudo losetup --find --show --partscan $@.tmp); \
	    cleanup+=("sudo losetup --detach $$dev"); \
	    \
	    sudo mount "$${dev}p1" $@.d; \
	    cleanup+=('sudo umount $@.d'); \
	    \
	    printf 'a:b.com\r\n' | sudo tee $@.d/setup.bat; \
	}
	rmdir $@.d
	mv $@.tmp $@

plan9-1e/sys/lib/pcdisk: plan9-1e.tar.bz2
	mkdir -p $(@D)
	bsdtar xfO $< $@ >$@

run-1e: plan9-1e-bootloader.img
run-1e: plan9-1e/sys/lib/pcdisk
	qemu-system-i386 -cpu 486 -hda plan9-1e-bootloader.img -fda plan9-1e/sys/lib/pcdisk -boot c

######################################################################

versions = 1e 2e 3e 4e 4e-latest
