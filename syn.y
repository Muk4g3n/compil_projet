%token import process loop array Programme READ WRITE adresse execute var if else end_if while CONST INTEGER STRING CHAR REAL superieur INF INFE EG SUPE DIFF pg pd ag ad varsep affectation fins bar float Int Char String text arithmethique taille format commentaire nomProgramme new_line 
%%
S:Programme nomProgramme new_line {printf('syntaxe correcte'); YYACCEPT;}

;
%%
int yyerror(char *msg)
{ printf("%s error syntaxique");
return 1; }
main ()
{
yyparse();
}
yywrap()
{}
