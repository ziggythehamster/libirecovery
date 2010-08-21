all:
	@echo "Please choose either macosx, linux, or windows"

static:
	gcc -o libirecovery.o -c src/libirecovery.c -g -I./include
	ar rs libirecovery.a libirecovery.o
	gcc -o irecovery src/irecovery.c -g -I./include -L. -lirecovery -lreadline -lusb-1.0

linux:
	gcc -o libirecovery.o -c src/libirecovery.c -g -I./include -lreadline -fPIC 
	gcc -o libirecovery.so libirecovery.o -g -shared -Wl,-soname,libirecovery.so -lusb-1.0
	gcc -o irecovery src/irecovery.c -g -I./include -L. -lirecovery -lreadline

macosx:
	gcc -o libirecovery.dylib -c src/libirecovery.c -dynamiclib -I./include -I/opt/local/include -L/opt/local/lib
	gcc -o irecovery src/libirecovery.c src/irecovery.c -I./include -I/opt/local/include -L/opt/local/lib -lreadline -lusb-1.0
	
windows:
	gcc -o libirecovery.dll -c src/libirecovery.c -I. -lusb-1.0 -lreadline -shared -fPIC
	gcc -o irecovery irecovery.c -I. -lirecovery -lreadline
	
install:
	#cp libirecovery.so /usr/local/lib/libirecovery.so
	cp libirecovery.dylib /usr/local/lib/libirecovery.dylib
	cp include/libirecovery.h /usr/local/include/libirecovery.h
	cp irecovery /usr/local/bin/irecovery
	
uninstall:
	#rm -rf /usr/local/lib/libirecovery.so
	rm -rf /usr/local/lib/libirecovery.dylib
	rm -rf /usr/local/include/libirecovery.h
	rm -rf /usr/local/bin/irecovery
		
clean:
	rm -rf irecovery libirecovery.o libirecovery.so libirecovery.dylib libirecovery.a
		

		
