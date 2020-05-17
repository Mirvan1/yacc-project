
nlyacc:start.y
	yacc -d start.y

nllex:start.l
	lex start.l

run:y.tab.c
	gcc y.tab.c -o example -ll -ly

texteditor:
	./example < exampleprog1.nl

clean:
	rm start.l
	rm lex.yy.c
	rm start.y
	rm y.tab.c
