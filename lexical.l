
%{
    #include<stdio.h>
    #include "bison.tab.h"
    extern nbligne;
    extern Col;
    extern YYSTYPE yylval;
    char *temp;
    int cpt;
%}

lettreM [A-Z]
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettreM}({lettre}|{chiffre})*
Comment "/*"(.|\n)*"*/"
texte ({lettre}|" ")*
Int ("(-"{chiffre}+")")|{chiffre}+
Float ("(-"{chiffre}+"."{chiffre}+")")|({chiffre}+"."{chiffre}+)
String (\")[^\n\t]+(\")
Char '[^\n\t]'
  

%%
Programme   {
                rechercher(yytext,"Mot cle"," ",0,1);
                return mc_pgm; }
INTEGER     {yylval.str = strdup(yytext);   rechercher(yytext,"Mot cle"," ",0,1);  Col= Col + strlen(yytext);   return mc_entier;}
REAL        {yylval.str = strdup(yytext);   rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_reel;}
STRING      {yylval.str = strdup(yytext);   rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_str;}
CHAR        {yylval.str = strdup(yytext);   rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_char;}
PROCESS     {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_process;}
LOOP        {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_loop;}
ARRAY       {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_array;}
VAR         {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_var;}
INSTRUCTION {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_instruction;}
CONST       {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext);   return mc_const;}

READ        {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_read;}
WRITE       {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_write;}
WHILE       {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_while;}
EXECUT      {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_execut;}
IF          {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_if;}
END_IF      {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_end_if;}
ELSE        {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_else;}

"|"         {rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return bar;}
"%"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return signe_real;}
"#"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return signe_string;}
"&"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return signe_char;}
{Int}       {
            Col= Col + strlen(yytext);
            if(yytext[0]=='('){
                yytext = yytext+1;
                yytext[yyleng-2] = '\0'; 
                
            }
            yylval.entier = atoi(yytext);
            rechercher(yytext,"const entier","INTEGER",yytext,0);
             
            return typeInt;}
{Float}     {
            Col= Col + strlen(yytext);
            if(yytext[0]=='('){
                yytext = yytext+1;
                yytext[yyleng-2] = '\0'; 
                
            }
            yylval.flt = atof(yytext); 
            rechercher(yytext,"const reel","REAL",yytext,0);
             
            return typeFloat;
            }
{String}    { yylval.str = strdup(yytext); Col= Col + strlen(yytext); rechercher_string(yytext,"const str","STRING",yytext);   return typeString;}
{Char}      { yylval.str = strdup(yytext); rechercher_string(yytext," const str","CHAR",yytext); Col= Col + strlen(yytext);   return typeChar;}
SUP         {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_sup;}
SUPE        {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_supe;}
EG          {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_eg;}
DIF         {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_dif;}
INFE        {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_infe;}
INF         {rechercher(yytext,"Mot cle"," ",0,1); Col= Col + strlen(yytext); return mc_inf;}


\"       return quotation_mark;

{IDF}       {
                
                if(yyleng >10) printf("Erreur lexicale: IDF trop long  ligne : %d Col :%d \n",nbligne,Col);
                else{
                    yylval.str = strdup(yytext);
                    rechercher(yytext,"IDF","nothing",0,0);
                     
                    Col= Col + strlen(yytext);
                    return IDF;
                }
            }


{Comment}   { printf("commentaire : %s \n",yytext);}

"("         { rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return paro;}
")"         {rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return parf;}
@         {rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return address;}


"##"        {rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return dz;} 
"/"         { yylval.str = strdup(yytext); rechercher(yytext,"sep"," ",0,2);  Col= Col + strlen(yytext); return division ;}
"+"         { yylval.str = strdup(yytext); rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return addition ;}
"*"         { yylval.str = strdup(yytext); rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return  multi;}
"-"         { yylval.str = strdup(yytext); rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return moins;}
"::"        {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return dpts ;}
"="         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return  egale;}
":="        {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return affectation  ;}
"$"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return fin;}
"{"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return acco ;}
"}"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return  accf;}
"["         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return crov;}
"]"         {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return  crof; }
"//"        {rechercher(yytext,"sep"," ",0,2); Col= Col + strlen(yytext); return sep;}

[ \t]        {Col = Col + strlen(yytext);}
\n          {nbligne++; printf("\n%d)   ",nbligne); Col = 1;}  
.           {printf("erreur lexical : %d:%d \n",nbligne,Col);}
%%
