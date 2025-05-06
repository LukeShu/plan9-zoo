$(thisdir)/FD14LITE.img: downloads/FD14-LiteUSB.zip
	bsdtar xfO $< FD14LITE.img >$@

$(thisdir)/boot-hdd.img: $(thisdir)/FD14LITE.img $(thisdir)/fdauto.bat $(thisdir)/fdconfig.sys
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
	    cp $(<D)/fdauto.bat $@.d/fdauto.bat; \
	    cp $(<D)/fdconfig.sys $@.d/fdconfig.sys; \
	    rm $@.d/setup.bat; \
	}
	rmdir $@.d
	mv $@.tmp $@

$(thisdir)/boot-floppy.img: downloads/plan9-1e.tar.bz2
	bsdtar xfO $< plan9-1e/sys/lib/pcdisk >$@

run/$(thisdir)/standalone: $(thisdir)/boot-hdd.img
run/$(thisdir)/standalone: $(thisdir)/boot-floppy.img
run/$(thisdir)/standalone: $(thisdir)/script.gdb
	qemu-system-i386 $(qemu_extra) \
	  -S -gdb unix:$(<D)/standalone.sock,server=on \
	  -cpu 486 \
	  -drive $(qemu-drive/hda),format=raw,readonly=off,file=$(<D)/boot-hdd.img \
	  -drive $(qemu-drive/fda),format=raw,readonly=on,file=$(<D)/boot-floppy.img \
	  -boot c & \
	gdb --nh --batch --command=$(<D)/script.gdb & \
	wait
.PHONY: run/$(thisdir)/standalone
