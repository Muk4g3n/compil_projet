%{
#include<stdio.h>
extern FILE* yyin ;
extern int yylineno;
extern int col;
int yylex();

%}
%union
{
	float real;
	char* chaine;
	int entier;

 


}
%token mc_int mc_real mc_pgm mc_begin mc_end blanc cst aff 
%token <chaine> idf
%start S
%%
S: entete declaration mc_begin corps mc_end { printf ("programme juste"); YYACCEPT;}
;
entete: mc_pgm  idf
;

declaration: type listeparam ';' declaration | type listeparam ';'
;

listeparam: listeparam ',' idf | idf
;

type: mc_int | mc_real
;

corps: corps inst | inst
;

inst : instaff
;

instaff: idf '=' idf ';'
;
%%
int yyerror(char *msg)
{

printf("%s ligne %d , colonne %d\n",msg,yylineno,col);

return 1;
}


int main()
{

yyin=fopen("inpput.txt","r");
yyparse();
return 0;
}

int yywrap(void)
{
}
