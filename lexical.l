
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
texte ({lettre}|" ")*
Int ("(-"{chiffre}+")")|{chiffre}+
Float ("(-"{chiffre}+"."{chiffre}+")")|({chiffre}+"."{chiffre}+)
String (\")[^\n\t]+(\")
Char '[^\n\t]'
  

%%
Programme   return mc_pgm; 
INTEGER     return mc_entier;
REAL        return mc_reel;
STRING      return mc_str;
PROCESS     return mc_process;
LOOP        return mc_loop;
ARRAY       return mc_array;
VAR         return mc_var;
INSTRUCTION return mc_instruction;
CONST       return mc_const;

READ        return mc_read;
WRITE       return mc_write;
WHILE       return mc_while;
EXECUT      return mc_execut;
IF          return mc_if;
END_IF      return mc_end_if;
ELSE        return mc_else;

"|"         return bar;
"%"         return signe_real;
"#"         return signe_string;
"&"         return signe_char;
{Int}       return typeInt;
{Float}     return typeFloat;
{String}    return typeString;
{Char}      return typeChar;
SUP         return mc_sup;
SUPE        return mc_supe;
EG          return mc_eg;
DIF         return mc_dif;
INFE        return mc_infe;
INF         return mc_inf;


\"       return quotation_mark;

{IDF}       {
                printf("idf : %s ",yytext);
                return IDF;
            }


{Comment}   { printf("commentaire : %s \n",yytext);}

"("         return paro;
")"         return parf;
@         return address;


"##"        return dz; 
"/"         return division ;
"+"         return addition ;
"*"         return  multi;
"-"         return moins;
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
\n          {nbr_lg++; printf("\n%d)   ",nbr_lg);}  
.           {printf("erreur lexical : %d dans %s \n",nbr_lg,yytext);}
%%

