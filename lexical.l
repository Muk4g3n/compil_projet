
%{
    #include<stdio.h>
    #include "bison.tab.h"
    int nbr_lg=1;
%}

lettreM [A-Z]
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettreM}({lettre}|{chiffre})*
cst{chiffre}+
Comment "/*"(.|\n)*"*/"
  

%%
Programme   return mc_pgm; 
INTEGER     return mc_entier;
REAL        return mc_reel;
STRING      return mc_str;
PROCESS     return mc_process;
LOOP        return mc_loop;
ARRAY       return mc_array;
VAR         return mc_var;
CONST       return mc_const;
{IDF}       {
                printf("idf : %s\n",yytext);
                return IDF;
            }
{cst}       return cst;

{Comment}   printf("commentaire : %s \n",yytext);

"##"        return dz; 
"/"         return division ;
"+"         return addition ;
"*"         return  multi;
"::"        return dpts ;
"="         return  egale;
":="        return affectation  ;
"$"         return fin;
"{"         return acco ;
"}"         return  accf;
"["         return crov;
"]"         return  crof; 
"//"        return sep;
[ \t] 
\n          {nbr_lg++; printf("%d)   ",nbr_lg);}  
.           {printf("erreur lexical : %d dans %s ",nbr_lg,yytext);}
%%

