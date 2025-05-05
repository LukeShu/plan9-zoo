downloads/plan9-sha256sums.txt:
	curl -L $(p9f_mirror)/sha256sum.txt >$@
p9f_check = (cd downloads && set -o pipefail && grep $1 plan9-sha256sums.txt | sha256sum --check)
downloads/plan9-%.bz2: downloads/plan9-sha256sums.txt FORCE
	$(call p9f_check,$(@F)) || (curl -L $(p9f_mirror)/$(@F) >$@ && $(call p9f_check,$(@F)))

downloads/FD13-verify.txt:
	curl -L https://freedos.org/download/verify.txt >$@
fd13_check = (cd downloads && set -o pipefail && grep -E "^[0-9a-f]{64}\s+$1" FD13-verify.txt | sha256sum --check)
downloads/FD13%.zip: downloads/FD13-verify.txt FORCE
	$(call fd13_check,$(@F)) || (curl -L $(fd13_mirror)/$(@F) >$@ && $(call fd13_check,$(@F)))
