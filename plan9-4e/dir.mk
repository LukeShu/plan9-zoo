plan9-4e/boot.iso: downloads/plan9-4e-latest.iso.bz2
	bzip2 -d <$< >$@

run/4e/pc/standalone: plan9-4e/boot.iso
	qemu-system-i386 $(qemu_extra) \
	  -drive $(qemu-drive/cdrom),format=raw,readonly=on,file=$<
.PHONY: run/4e/pc/standalone
