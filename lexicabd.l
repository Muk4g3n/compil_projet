%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<syn.tab.h>
    #include<string.h>
    int nblg=1;
%}

chiffre [0-9]
chiffrepos [1-9]{chiffre}*
lettrem [a-z]
lettreM [A-Z]
lettre {lettreM}|{lettrem}
Idf {lettreM}({lettre}|{chiffre})+
Int ("(-"{chiffre}+")")|{chiffre}+
Float ("(-"{chiffre}+"."{chiffre}+")")|{chiffre}+"."{chiffre}+
String {lettre}{lettre}+
Tableau {Idf}"["{chiffrepos}{chiffre}*"]"
Comment "/*"(.|\n)*"*/"

%%
"##" {return import ;}
"PROCESS" {return process;}
"LOOP" {return loop;}
"ARRAY" {return array;}
"PROGRAMME"  {return programme;}
"INTEGER" {return INTEGER;}
"STRING" {return STRING;}
"CHAR" {return CHAR;}
"REAL" {return REAL;}
"//" {return varsep;}
"$" {return fins;}":="{return affectation;}
"{" {return ag;}
"}" {return ad;}
"(" {return pg;}
")" {return pd;}
"while" {return while;}
"EXECUT" {return execute;}
"IF" {return if;}
"ELSE" {return else;}
"END_IF" {return endif;}
"READ" {return read;}
"WRITE" {return write;}
"+" {return add;}
"*" {return multp;}
"-" {return minus;}"/"{return div;}
"SUP" {return sup;}
"SUPE" {return supeg;}
"EG" {return egale;}
"DIFF" {return dif;}
"INFE" {return infeg;}
"INF" {return inf;}
{Int} {return int;}
{Float} {return float;}
{lettre} {return char;}
{String} {return string;}
{Idf} {
        if(yyleng<11){
            return idf;
             printf("idf : %s \n",yytext);
        }else printf("erreur la taille de l'idf est >10 \n")
}
{Tableau} {return table;}
{Comment} {return cmtr;}

\n  { nblg=nblg+1; }
[ \t]+
. {printf("erreur dans la ligne %d",nblg);}

%%
{   //Idf {lettreM}({lettre}|{chiffre}){0,10}
    yyin = fopen("programme.txt","r");
    if(yyin==NULL) printf("ERROR\n");
    else yylex();
}
