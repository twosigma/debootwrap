all: seccomp-filter pre-depends.patch

gen-seccomp-filter: gen-seccomp-filter.c
	$(CC) -o $@ $< -lseccomp

seccomp-filter: gen-seccomp-filter
	./gen-seccomp-filter > $@

pre-depends.patch:
	curl https://salsa.debian.org/installer-team/debootstrap/commit/e24e4b006736734e20cc66398099b94dd4e5cb90.patch | filterdiff -i '*/functions' > $@

clean:
	$(RM) gen-seccomp-filter seccomp-filter pre-depends.patch

.PHONY: all clean
