plan9-1e/FD14LITE.img: downloads/FD14-LiteUSB.zip
	bsdtar xfO $< FD14LITE.img >$@

plan9-1e/boot-hdd.img: plan9-1e/FD14LITE.img plan9-1e/fdauto.bat plan9-1e/fdconfig.sys
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
	    cp plan9-1e/fdauto.bat $@.d/fdauto.bat; \
	    cp plan9-1e/fdconfig.sys $@.d/fdconfig.sys; \
	    rm $@.d/setup.bat; \
	}
	rmdir $@.d
	mv $@.tmp $@

plan9-1e/boot-floppy.img: downloads/plan9-1e.tar.bz2
	bsdtar xfO $< plan9-1e/sys/lib/pcdisk >$@

plan9-1e/run: plan9-1e/boot-hdd.img
plan9-1e/run: plan9-1e/boot-floppy.img
plan9-1e/run: plan9-1e/script.gdb
	qemu-system-i386 $(qemu_extra) \
	  -S -gdb unix:$@.sock,server=on \
	  -cpu 486 \
	  -drive $(qemu-drive/hda),format=raw,readonly=off,file=plan9-1e/boot-hdd.img \
	  -drive $(qemu-drive/fda),format=raw,readonly=on,file=plan9-1e/boot-floppy.img \
	  -boot c & \
	gdb --nh --batch --command=plan9-1e/script.gdb & \
	wait
.PHONY: plan9-1e/run
