%{
  #include <stdio.h>
  #include <string.h>
  #include "extensor.tab.h"

%}

var         ([_a-zA-Z][_a-zA-Z0-9]*)
number      ([0-9]+)

%%

ENTRADA     {yylval.id=strdup(yytext); return (ENTRADA);}
SAIDA       {yylval.id=strdup(yytext); return (SAIDA);}
FIM         {yylval.id=strdup(yytext); return (FIM);}
ENQUANTO    {yylval.id=strdup(yytext); return (ENQUANTO);}
FACA        {yylval.id=strdup(yytext); return (FACA);}
INC         {yylval.id=strdup(yytext); return (INC);}
ZERA        {yylval.id=strdup(yytext); return (ZERA);}
SE          {yylval.id=strdup(yytext); return (SE);}
ENTAO       {yylval.id=strdup(yytext); return (ENTAO);}
VEZES       {yylval.id=strdup(yytext); return (VEZES);}
DEC 	      {yylval.id=strdup(yytext); return (DEC);}
[=()]       {return yytext[0]; }
{var}       {yylval.id=strdup(yytext); return (ID);}
{number}    {yylval.id=strdup(yytext); return (NUM);}
.           ;

%%
