include config.mk

prompt_pwd: prompt_pwd.c
	${CC} ${CFLAGS} -o prompt_pwd prompt_pwd.c

install:
	@echo Installing to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f prompt_pwd ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/prompt_pwd

uninstall:
	@echo Uninstalling from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/prompt_pwd

clean:
	@rm -f prompt_pwd
	@rm -f prompt_pwd.exe

runtests:
	sh test/test.sh

gcc:
	gcc ${CFLAGS} ${CSTDFLAGS} -o prompt_pwd prompt_pwd.c

check: clean gcc runtests
