$(thisdir)/plan9.iso: downloads/plan9-4e-latest.iso.bz2
	bzip2 -d <$< >$@

run/$(thisdir)/386-pc/standalone: $(thisdir)/plan9.iso
	qemu-system-i386 $(qemu_extra) \
	  -drive $(qemu-drive/cdrom),format=raw,readonly=on,file=$<
.PHONY: run/$(thisdir)/pc/standalone
