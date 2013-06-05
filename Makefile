BUILD_TARGETS = wcwidth-cjk wcwidth-cjk.so

CC = gcc
CFLAGS = -O2 -Wall -fPIC -Dwcwidth_cjk=wcwidth
LDSHARED = $(CC) -shared
LDFLAGS =

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(exec_prefix)/lib

default: build

clean:
	rm -f $(BUILD_TARGETS)
	rm -f *.o *.so *.tmp

install:
	mkdir -m 0755 -p $(bindir)
	cp wcwidth-cjk $(bindir)/
	mkdir -m 0755 -p $(libdir)
	cp wcwidth-cjk.so $(libdir)/

build: $(BUILD_TARGETS)

wcwidth-cjk: wcwidth-cjk.sh
	sed 's#@libdir@#$(libdir)#g' wcwidth-cjk.sh >$@.tmp
	chmod +x $@.tmp
	mv $@.tmp $@

wcwidth-cjk.o: wcwidth-cjk.c

wcwidth-cjk.so: wcwidth.o
	$(LDSHARED) $(LDFLAGS) -o $@ wcwidth.o

