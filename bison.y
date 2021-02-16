%{
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>

extern FILE* yyin ;
int yylex();
int yyerror();
int yyparse();
%}
%token mc_pgm mc_entier mc_reel mc_str mc_process mc_loop mc_array mc_const mc_var IDF
%token cst dz division addition multi dpts egale affectation fin acco 
%token accf crov crof sep mc_instruction
%token mc_read paro parf mc_write bar address
%token mc_while mc_execut mc_if mc_else mc_end_if


%start S
%%
S: LIST_BIB mc_pgm IDF acco DEC  accf {printf("la chaine est correct\n");YYACCEPT;}
    ;

LIST_BIB: LIST_BIB BIB
        |
        ;

BIB: dz NOM_BIB fin  
    ;

NOM_BIB: mc_loop
        | mc_process
        |  mc_array
        ;

DEC:DEC_VAR DEC_INST
    |
    ;

DEC_VAR:  mc_var LIST_DEC  mc_const LIST_CST
        |  mc_const LIST_CST mc_var LIST_DEC
        | mc_var LIST_DEC
        | mc_const LIST_CST
        |
        ;

LIST_DEC:TYPE dpts LIST_IDF  LIST_DEC
        |
        ;

LIST_IDF: IDF sep LIST_IDF
        | IDF crov cst crof sep LIST_IDF 
        | IDF fin
        | IDF crov cst crof fin
        ;

LIST_CST:TYPE dpts LIST_IDF_CST LIST_CST
        |
        ;   
LIST_IDF_CST: IDF affectation cst sep LIST_IDF_CST
            | IDF affectation cst fin
            ;

DEC_INST: mc_instruction DEC_READ DEC_WRITE

        ;
DEC_READ: mc_read paro bar address IDF parf fin

        ;
DEC_WRITE: mc_write paro bar IDF parf fin
         ;
TYPE: mc_entier
    | mc_reel
    | mc_str
    ;
%%
int yyerror(void){ return 0;
}

void main(int argc, char* argv[]){
    int fd;
    yyin=fopen(argv[1],"r");
	fd =open(argv[1],O_RDONLY);
    yyparse();
}
int yywrap(void){return 0;}


