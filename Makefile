# discrete_dmenu - discrete dynamic menu
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c discrete_dmenu.c util.c
OBJ = ${SRC:.c=.o}

all: options discrete_dmenu 

options:
	@echo discrete_dmenu build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

${OBJ}: arg.h config.h config.mk drw.h

discrete_dmenu: discrete_dmenu.o drw.o util.o
	@echo CC -o $@
	@${CC} -o $@ discrete_dmenu.o drw.o util.o ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f discrete_dmenu ${OBJ} discrete_dmenu-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p discrete_dmenu-${VERSION}
	@cp LICENSE Makefile README arg.h config.def.h config.mk discrete_dmenu.1 \
		drw.h util.h discrete_dmenu discrete_dmenu  ${SRC} \
		discrete_dmenu-${VERSION}
	@tar -cf discrete_dmenu-${VERSION}.tar discrete_dmenu-${VERSION}
	@gzip discrete_dmenu-${VERSION}.tar
	@rm -rf discrete_dmenu-${VERSION}

install: all
	@echo installing executables to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f discrete_dmenu discrete_dmenu discrete_dmenu ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@chmod 755 ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@chmod 755 ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@echo installing manual pages to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < discrete_dmenu.1 > ${DESTDIR}${MANPREFIX}/man1/discrete_dmenu.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/discrete_dmenu.1

uninstall:
	@echo removing executables from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@rm -f ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@rm -f ${DESTDIR}${PREFIX}/bin/discrete_dmenu
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/discrete_dmenu.1

.PHONY: all options clean dist install uninstall
