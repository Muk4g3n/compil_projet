bison -d bison.y
flex lexical.l
gcc lex.yy.c bison.tab.c -lfl -ly -o compiler