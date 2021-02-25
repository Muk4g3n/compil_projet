%{
 #include<stdio.h>
 #include<stdlib.h>
 #include<string.h>
 #include "synt.tab.h"
 extern YYSTYPE yylval;
 int yylineo=1;
 int col=1;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
cst {chiffre}+
real {chiffre}+"."{chiffre}+

%%
INTEGER {
	     col=col+yyleng; 
	     printf("le mot clé  %s est reconnu \n",yytext);
         return mc_int;
        }
REAL {
	     col=col+yyleng; 
	     printf("le mot clé  %s est reconnu \n",yytext);
         return mc_real;
        }		
PROGRAM {
		printf("le mot clé %s est reconnu\n",yytext);
		col=col+yyleng; 
		return mc_pgm;
	  }
BEGIN {
		printf("le mot clé %s est reconnu\n",yytext);
		col=col+yyleng; 
		return mc_begin;
	  }	  
END {
		printf("le mot clé %s est reconnu\n",yytext);
		col=col+yyleng; 
		return mc_end;
	  }	  
{idf}  { 
	  if (yyleng <12) 
          {     col=col+yyleng; 
		        printf("lidf %s est reconnu \n",yytext);
                return idf;
          }		
          else printf ("erreur lexical : idf long\n");
       }
{cst} {return cst;}
"=" { col=col+1;  return '=';}
";" { col=col+1;  return ';';}
\n {yylineo++; col=1;}
[ \t]+ {printf("espaceeeeeeeee\n"); col=col+yyleng; }
. {printf("Erreur lexicale ligne %d colonne %d\n",yylineo,col); }
%%
