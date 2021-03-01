
%{
    #include<stdio.h>
    #include "bison.tab.h"
    #include "TS.h"
    int nbr_lg=1;
    extern YYSTYPE yylval;
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
Programme   {
                rechercher(yytext,"Mot cle",0,1);
                return mc_pgm; }
INTEGER     {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_entier;}
REAL        {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_reel;}
STRING      {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_str;}
PROCESS     {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_process;}
LOOP        {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_loop;}
ARRAY       {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_array;}
VAR         {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_var;}
INSTRUCTION {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_instruction;}
CONST       {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_const;}

READ        {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_read;}
WRITE       {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_write;}
WHILE       {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_while;}
EXECUT      {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_execut;}
IF          {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_if;}
END_IF      {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_end_if;}
ELSE        {rechercher(yytext,"Mot cle",0,1); printf("entite lexical reconnu est %s",yytext); return mc_else;}

"|"         {rechercher(yytext,"sep",0,2); return bar;}
"%"         {rechercher(yytext,"sep",0,2); return signe_real;}
"#"         {rechercher(yytext,"sep",0,2); return signe_string;}
"&"         {rechercher(yytext,"sep",0,2); return signe_char;}
{Int}       {yylval.entier = atoi(yytext); rechercher(yytext,"entier",atof(yytext),0); return typeInt;}
{Float}     { yylval.flt = atof(yytext); rechercher(yytext,"float",atof(yytext),0); return typeFloat;}
{String}    { yylval.str = yytext; return typeString;}
{Char}      { yylval;str = yytext; return typeChar;}
{cst}       {yylval.entier = atoi(yytext); rechercher(yytext,"entier"," ",atof(yytext),0) return cst;}
SUP         {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_sup;}
SUPE        {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_supe;}
EG          {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_eg;}
DIF         {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_dif;}
INFE        {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_infe;}
INF         {rechercher(yytext,"Mot cle"," ",0,1); printf("entite lexical reconnu est %s",yytext); return mc_inf;}


\"       return quotation_mark;

{IDF}       {
                printf("idf : %s ",yytext);
                yylval.str = strdup(yytext);
                rechercher(yytext,"IDF"," ",0,0);
                if(yyleng >10) printf("Erreur lexicale: IDF long ");
                return IDF;
            }


{Comment}   { printf("commentaire : %s \n",yytext);}

"("         { rechercher(yytext,"sep",0,2); return paro;}
")"         {rechercher(yytext,"sep",0,2); return parf;}
@         {rechercher(yytext,"sep",0,2); return address;}


"##"        {rechercher(yytext,"sep",0,2); return dz;} 
"/"         {rechercher(yytext,"sep",0,2); return division ;}
"+"         {rechercher(yytext,"sep",0,2); return addition ;}
"*"         {rechercher(yytext,"sep",0,2); return  multi;}
"-"         {rechercher(yytext,"sep",0,2); return moins;}
"::"        {rechercher(yytext,"sep",0,2); return dpts ;}
"="         {rechercher(yytext,"sep",0,2); return  egale;}
":="        {rechercher(yytext,"sep",0,2); return affectation  ;}
"$"         {rechercher(yytext,"sep",0,2); return fin;}
"{"         {rechercher(yytext,"sep",0,2); return acco ;}
"}"         {rechercher(yytext,"sep",0,2); return  accf;}
"["         {rechercher(yytext,"sep",0,2); return crov;}
"]"         {rechercher(yytext,"sep",0,2); return  crof; }
"//"        {rechercher(yytext,"sep",0,2); return sep;}

[ \t] 
\n          {nbr_lg++; printf("\n%d)   ",nbr_lg);}  
.           {printf("erreur lexical : %d \n",nbr_lg);}
%%

int main(){
    initialisation();
}