# NOTE1: You can use wildcards in dependencies and g++ command.
# NOTE2: main should depend on all headers and code files. (*.h and *.cpp if you have multiple files)
all: ../main

../main: lex.yy.c lex.yy.h parser.tab.c parser.tab.h main.cpp
	g++ -o ../main -std=c++14 parser.tab.c lex.yy.c main.cpp

lex.yy.c lex.yy.h: scanner.l
	flex scanner.l

parser.tab.c parser.tab.h: parser.y
	bison -dv parser.y

clean:
	rm ../main lex.yy.c lex.yy.h parser.tab.c parser.tab.h parser.output
