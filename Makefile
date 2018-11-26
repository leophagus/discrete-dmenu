# discrete_dmenu - discrete dynamic menu
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c discrete_dmenu.c util.c locgen.c
OBJ = ${SRC:.c=.o}

all: options discrete_dmenu locgen

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

locgen: locgen.o
	@echo CC -o $@
	@${CC} -o $@ locgen.o ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f discrete_dmenu locgen ${OBJ}

.PHONY: all options clean 
