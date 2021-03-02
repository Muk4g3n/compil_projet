
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_pgm = 258,
     mc_entier = 259,
     mc_reel = 260,
     mc_str = 261,
     mc_process = 262,
     mc_loop = 263,
     mc_array = 264,
     mc_const = 265,
     mc_var = 266,
     IDF = 267,
     dz = 268,
     division = 269,
     addition = 270,
     multi = 271,
     dpts = 272,
     egale = 273,
     affectation = 274,
     cst = 275,
     fin = 276,
     acco = 277,
     accf = 278,
     crov = 279,
     crof = 280,
     sep = 281,
     mc_instruction = 282,
     mc_read = 283,
     paro = 284,
     parf = 285,
     mc_write = 286,
     bar = 287,
     address = 288,
     mc_while = 289,
     mc_execut = 290,
     mc_if = 291,
     mc_else = 292,
     mc_end_if = 293,
     typeInt = 294,
     typeFloat = 295,
     typeString = 296,
     typeChar = 297,
     mc_sup = 298,
     mc_supe = 299,
     mc_eg = 300,
     mc_dif = 301,
     mc_infe = 302,
     mc_inf = 303,
     quotation_mark = 304,
     signe_real = 305,
     signe_string = 306,
     signe_char = 307,
     moins = 308
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 14 "bison.y"

        int entier;
        char* str;
        float flt;



/* Line 1676 of yacc.c  */
#line 113 "bison.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


