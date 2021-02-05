%{
    #include<stdio.h>
    int nblignes  = 1;
%}
/*decalaration des regex */
Type [CHAR|STRING|REAL|INTEGER]
Idf [A-Z][a-zA-Z0-9]{0,9}
Format [$|%|#|&]
Text \"[A-Za-z0-9]*{Format}*\"
Art [\+|\*|-|/]
Number ([1-9][0-9]*)|0
Taille \[{Number}\]
Int -?{Number}
Float {Number}\.[0-9]*[1-9]|-\({Number}\.[0-9]*[1-9]\)
Char \'.\'
String \'.*\'
Commentaire \/\*[^(\/\*|\*\/)]\*\/
nomProgramme [a-zA-Z][a-zA-Z0-9]* 
%%
"##" {return import;}
"PROCESS" {return process; printf("process");}
"LOOP" {return loop; printf("loop");}
"ARRAY" {return array;printf("array");}
"Programme" {return Programme;}
"READ" {return entré;}
"WRITE" {return sortie;}
"@" {return adresse;}
"EXECUT" {return execute;}
"VAR" {return var;}
"IF" {return if;}
"ELSE" {return else;}
"END_IF" {return end_if;}
"WHILE" {return while;}
"CONST" {return CONST;}
"INTEGER" {return INTEGER;}
"STRING" {return STRING;}
"CHAR" {return CHAR;}
"REAL" {return REAL;}
"SUP" {return superieur;}
"INF" {return INF;}
"INFE" {return INFE;}
"EG" {return EG;}
"SUPE" {return SUPE;}
"DIFF" {return DIFF;}
"(" {return pg;}
")" {return pd;}
"{" {return ag;}
"}" {return ad;}
"//" {return varsep;}
":=" {return affectation;}
"$" {return fins; printf("fin instruction");}
"|" {return bar;}
{Float} {return float;}
{Int} {return Int;}
{Char} {return Char;}
{String} {return String;}
{Text} {return text;}
{Art} {return arithmethique;}
{Taille} {return taille;}
{Format} {return format;}
{Commentaire} {return commentaire;}
{nomProgramme} {return nomProgramme;}
\n {nblignes++; return new_line;}
[ \t]
. {printf("erreur dans la ligne %d a l'entite %s",nblignes,yytext); return err;}
