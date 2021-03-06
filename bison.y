%{
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
#include "TS.h"

extern FILE* yyin ;
int nbligne=1,Col=1;
char* sauvtype;
int sauvtaille;
int sauvval;
char *sauvafftype,sauvafftype1,sauvopr;
%}
%union{
        int entier;
        char* str;
        float flt;
}
%token mc_pgm mc_entier mc_reel mc_str mc_char mc_process mc_loop mc_array mc_const mc_var IDF
%token  dz division addition multi dpts egale affectation  fin acco 
%token accf crov crof sep mc_instruction
%token mc_read paro parf mc_write bar address
%token mc_while mc_execut mc_if mc_else mc_end_if
%token typeInt typeFloat typeString typeChar
%token mc_sup mc_supe mc_eg mc_dif mc_infe mc_inf
%token quotation_mark
%token signe_real signe_string signe_char moins

%type <str> IDF typeChar typeString mc_str mc_char mc_reel mc_entier TYPE division
%type <entier> typeInt 
%type <flt> typeFloat 

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
        | mc_const LIST_CST mc_var LIST_DEC
        | mc_var LIST_DEC
        | mc_const LIST_CST
        |
        ;

LIST_DEC: TYPE dpts LIST_IDF  LIST_DEC
        | 
        ;

LIST_IDF: IDF sep LIST_IDF {   
                                if(double_declaration($1)==0){
                                 inserer_type($1,sauvtype);
                                 }
                                else
                                 printf("erreur semantique : idf doublement declare ligne %d : col %d : %s \n",nbligne,Col,$1);
                           }
        | IDF_TABLEAU LIST_IDF
        | IDF fin { 
                       if(double_declaration($1)==0){
                                 inserer_type($1,sauvtype);
                                 }
                                else
                                 printf("erreur semantique : idf doublement declare ligne %d : col %d : %s \n",nbligne,Col,$1);
                  }
        | IDF_TABLEAU fin
        ;

LIST_CST:TYPE dpts LIST_IDF_CST LIST_CST
        |
        ;   
LIST_IDF_CST: IDF affectation TYPE_IDF sep LIST_IDF_CST { 
                                                        if(double_declaration($1)==0){
                                                        inserer_type($1,sauvtype);
                                                        if(compare_type($1,sauvafftype) == 0){
                                                        printf("erreur semantique : type incompatible, Ligne %d : Col %d\n",nbligne,Col);
                                                        }
                                                        }
                                                        else
                                                        printf("erreur semantique : idf doublement declare ligne %d : col %d : %s \n",nbligne,Col,$1);
                                                        }
            | IDF affectation TYPE_IDF fin { 
                                                if(double_declaration($1)==0){
                                                inserer_type($1,sauvtype);
                                                if(compare_type($1,sauvafftype) == 0){
                                                        printf("erreur semantique : type incompatible, Ligne %d : Col %d\n",nbligne,Col);
                                                }
                                                }
                                                else
                                                printf("erreur semantique : idf doublement declare ligne %d : col %d : %s \n",nbligne,Col,$1);
                                                }
            ;



DEC_INST: DEC_INST2 DEC_INST
        |DEC_INST2
        ;
DEC_INST2:DEC_READ 
         |DEC_WRITE 
         |DEC_WHILE 
         |DEC_AFFECTATION 
         |DEC_EXECUT 
         ;

DEC_READ:mc_read paro typeString  bar address IDF parf fin {
                                                                if(double_declaration($6)==0){
                                                                printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$6);
                                                                }
                                                                }
        ;

DEC_WRITE: mc_write paro typeString DEC_WRITE2 parf fin
         
         ;
DEC_WRITE2: bar IDF DEC_WRITE2 {
                                 if(double_declaration($2)==0){
                                printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$2);
                                }
                                }
          | 
          ;

DEC_WHILE: mc_while paro DEC_COND parf acco DEC_AFFECTATION accf {
                                                                     if(rechercher_BIB("LOOP")==0) {printf("erreur semantique : manque de bibliotheque LOOP, Ligne %d: Col%d \n",nbligne,Col);}   
                                                                        }
         ;
DEC_AFFECTATION: IDF affectation DEC_AFFECTATION2 fin {
                                                        
                                                         if(double_declaration($1)==0){
                                                        printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$1);
                                                                                        }
                                                        else {
                                                                inserer_tab_operand(get_type($1));
                                                                 if(compare_type_tab()==0)
                                                                {   
                                                                printf("erreur semantique : type non compatible, Ligne %d : Col %d \n",nbligne,Col);
                                                                }
                                                        }
                                                        }
                | IDF_TABLEAU2 affectation DEC_AFFECTATION2 fin
                ;
DEC_AFFECTATION2: TYPE_IDF OPERATEUR_ARITHMETHIQUE DEC_AFFECTATION2  {
                                                        inserer_tab_operand(sauvafftype);
                                                        }
                | IDF OPERATEUR_ARITHMETHIQUE DEC_AFFECTATION2 {
                                                                if(double_declaration($1)!=0){
                                                                printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$1);
                                                                }
                                                                else inserer_tab_operand(get_type($1));
                                                                }
                | TYPE_IDF2
                | IDF2
                ;
DEC_COND2: TYPE_IDF OPERATEUR_ARITHMETHIQUE DEC_COND2 {
                                                        inserer_tab_operand(sauvafftype);
                                                        }
         | IDF OPERATEUR_ARITHMETHIQUE  DEC_COND2 {
                                                        if(double_declaration($1)!=1){
                                                        printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$1);
                                                        }
                                                        else inserer_tab_operand(get_type($1));
                                                                                        }   
         | TYPE_IDF2 {
                 if(compare_type_tab()==0)
                 {   
                         printf("erreur semantique : type non compatible, Ligne %d : Col %d \n",nbligne,Col);
                 }
         }
         |IDF2 {
                 if(compare_type_tab()==0)
                 {
                         printf("erreur semantique : type non compatible, Ligne %d : Col %d \n",nbligne,Col);
                 }
         }
         ;

IDF2: IDF {
              if(double_declaration($1)==0){
                        printf("erreur semantique: variable non-declare ligne %d : col %d : %s",nbligne,Col,$1);
                }
                else{
                        inserer_tab_operand(get_type($1));
                }
}
;
DEC_COND:DEC_COND2 OPERATEUR_COMPARAISON DEC_COND2
        |
        ;

DEC_EXECUT:mc_execut DEC_AFFECTATION mc_if paro DEC_COND parf DEC_EXECUT_ELSE  mc_end_if
          ;

DEC_EXECUT_ELSE: mc_else mc_execut DEC_AFFECTATION
                |
                ;


TYPE: mc_entier {
                 sauvtype = strdup($1);
                
                }
      |mc_reel {
                 sauvtype = strdup($1);
                
                }
      |mc_char {
                sauvtype = strdup($1);
                 
                }
      |mc_str {
                 sauvtype = strdup($1);
                 
                }
      ;
IDF_TABLEAU:IDF crov typeInt crof  {
                                        if(rechercher_BIB("ARRAY")==0) {printf("erreur semantique : manque de bibliotheque ARRAY, Ligne %d: Col%d \n",nbligne,Col);}
                                        else{   
                                                  if(double_declaration($1)==0){
                                                        inserer_type($1,sauvtype);
                                                
                                                        if($3 <0) {
                                                        printf("erreur semantique :taille de tableau non valide %d:%d \n",nbligne,Col);
                                                
                                                                }
                                                        else inserer_taille($1,$3);
                                                 }
                                                 else
                                                  printf("erreur semantique : idf doublement declare ligne %d : col %d : %s \n",nbligne,Col,$1);
                                                 
               
                                        }

}
;

IDF_TABLEAU2:IDF crov typeInt crof  {
                                        if(rechercher_BIB("ARRAY")==0) {printf("erreur semantique : manque de bibliotheque ARRAY, Ligne %d: Col%d \n",nbligne,Col);}
                                        else{   
                                                        if(double_declaration($1)==0){
                                                        printf("erreur semantique : variable non-declare ligne %d : col %d : %s\n" ,nbligne,Col,$1);
                                                        
                                                        }
                                                        else {
                                                                if($3> get_taille($1)) {printf("erreur semantique : depassement de la taille de tableau ligne %d : col %d \n",nbligne,Col);}
                                                        }
                                        }

}
;

TYPE_IDF: typeInt {
                        inserer_tab_operand("INTEGER");
                        sauvval = $1;
                        }
        |typeFloat {
                        sauvafftype = strdup("REAL");
                        }               
        |typeString {
                        sauvafftype = strdup("STRING");
                        } 
        |typeChar {
                        sauvafftype = strdup("CHAR");

                } 
        ;
 
TYPE_IDF2: typeInt {
                        inserer_tab_operand("INTEGER");
                        sauvval = $1;
                        }
        |typeFloat {
                        inserer_tab_operand("REAL");
                        }               
        |typeString {
                        inserer_tab_operand("STRING");
                        } 
        |typeChar {
                        inserer_tab_operand("CHAR");
                } 
        ;

OPERATEUR_ARITHMETHIQUE:division {
                                        if(rechercher_BIB("PROCESS")==0) {
                                                printf("erreur semantique : manque de bibliotheque PROCESS, Ligne %d: Col%d \n",nbligne,Col);
                                                }
                                        else {
                                                sauvopr = strdup($1);
                                        }
                                }
                        |addition {
                                        if(rechercher_BIB("PROCESS")==0) {printf("erreur semantique : manque de bibliotheque PROCESS, Ligne %d: Col%d \n",nbligne,Col);}
                                }
                        |multi {
                                        if(rechercher_BIB("PROCESS")==0) {printf("erreur semantique : manque de bibliotheque PROCESS, Ligne %d: Col%d \n",nbligne,Col);}
                                }
                        |moins {
                                        if(rechercher_BIB("PROCESS")==0) {printf("erreur semantique : manque de bibliotheque PROCESS, Ligne %d: Col%d \n",nbligne,Col);}
                                }
                        ;
        
OPERATEUR_COMPARAISON:mc_sup
                     |mc_supe
                     |mc_eg
                     |mc_dif
                     |mc_inf
                     |mc_infe
                     ;
%%
int yyerror(void){ return 0;
}

int main(){
        initialisation();
        yyparse();
        afficher();
}
int yywrap(void){
        
        return 0;}
