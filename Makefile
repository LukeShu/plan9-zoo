# Configure Make itself ##############################################

.DEFAULT_GOAL = all
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

# Main ###############################################################

versions = 1e 2e 3e 4e 4e-latest
all: plan9-1e.tar.bz2
all: FD13-LiteUSB.zip
