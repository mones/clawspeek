#
# Clawspeek makefile
#
NAME = clawspeek
VERSION = 1.0

PREFIX ?= /usr/local
BINDIR = ${PREFIX}/bin
DATADIR = ${PREFIX}/share
MANDIR = ${DATADIR}/man
MAN1DIR = ${MANDIR}/man1

CC = gcc
POD = pod2man
CFLAGS += $(shell pkg-config --cflags glib-2.0) 
LIBS = $(shell pkg-config --libs glib-2.0)
PCKF = passcrypt
PCK = $(shell echo 'A2DD<6J_' | tr '\!-~' 'P-~\!-O')

all: build manpage

manpage: $(NAME).pod
	$(POD) --utf8 --release $(VERSION) -c '' $(NAME).pod > $(NAME).1

build: $(NAME).c $(PCKF).h
	$(CC) $(CFLAGS) -o $(NAME) base64.c $(PCKF).c $(NAME).c $(LIBS) -lcrypt

$(PCKF).h: $(PCKF).h.in
	@sed "s,@PCK@,$(PCK)," < $< > $@	

clean:
	rm -f $(NAME) $(PCKF).h

install: all install-dirs
	install -m 0755 ${NAME} ${DESTDIR}${BINDIR}
	install -m 0644 ${NAME}.1 ${DESTDIR}${MAN1DIR}
	
install-dirs:
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MAN1DIR}

uninstall:
	rm -f ${DESTDIR}${BINDIR}/${NAME}
	rm -f ${DESTDIR}${MAN1DIR}/${NAME}.1

.PHONY: all build manpage install install-dirs uninstall

