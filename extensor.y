 
%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>

  int yylex();
  void yyerror();
  extern FILE *yyin; //configura como arquivo para yyparse

  void yyerror(){
  	fprintf(stderr, "Erro de Sintaxe");
	};  

%}

%union {int num; char *id;}
%token <id> ENTRADA SAIDA FIM ENQUANTO FACA INC ZERA DEC VEZES SE ENTAO ID NUM
%type <id> cmd cmds varlist

%%


program:
  	ENTRADA varlist SAIDA varlist cmds FIM 
	{
    		FILE *saida = fopen("extendido.txt", "w");
    		char* code = malloc(strlen($1) + strlen($2) +strlen($3) +strlen($4) + strlen($5) + strlen($6) + 18);
    		strcpy(code, $1); strcat(code, " "); strcat(code, $2); strcat(code, " ");  //ENTRADA VARLIST (X, Y)
				strcat(code, "BOOL1 COUNTER ");
        strcat(code, $3); strcat(code, " "); strcat(code, $4); strcat(code, "\n"); //SAIDA Z
    		strcat(code, $5); //cmds
        strcat(code, $6); //FIM
        strcat(code, "\n");
    		fprintf(saida, "%s", code);
    		fclose(saida);
	      printf("EXTENDIDO GERADO"); 
    		exit(0);
  }
;

varlist:
  	varlist ID 
		{
	    char* varlist = malloc(strlen($1) + 2 + strlen($2));
	    strcpy(varlist, $1); strcat(varlist, " "); strcat(varlist, $2);
	    $$ = varlist;
  	}
  	| ID {$$ = $1;}
;

cmds:
  	cmd cmds 
		{
	    char* cmds = malloc(strlen($1) + strlen($2) + 1);
	    strcpy(cmds, $1); strcat(cmds, $2); $$ = cmds;
  	}
  	| cmd {$$ = $1;}
;

cmd:
  ENQUANTO ID FACA cmds FIM 
	{
    char* cmd = malloc(6+ strlen($1) + strlen($2) + strlen($3) + strlen($4) + strlen($5));
    strcat(cmd, $1); strcat(cmd, " "); strcat(cmd, $2); strcat(cmd, " ");
    strcat(cmd, $3); strcat(cmd, "\n");
    strcat(cmd, $4);
    strcat(cmd, $5); strcat(cmd, "\n");
    $$ = cmd;
  }
  | ID '=' ID 
	{
    char* cmd = malloc(6 + strlen($1) + strlen($3)); 
    strcpy(cmd, $1);
    strcat(cmd, " = "); strcat(cmd, $3); strcat(cmd, "\n"); 
    $$ = cmd;
  }
  | ID '=' NUM 
	{
    char* cmd = malloc(strlen($1) + strlen($3) + 6); strcpy(cmd, $1);
    strcat(cmd, " = "); strcat(cmd, $3); strcat(cmd, "\n"); 
    $$ = cmd;
  }
  | INC '(' ID ')' 
	{
    char* cmd = malloc(strlen($1) + strlen($3) + 5); strcpy(cmd, $1); strcat(cmd, "(");
    strcat(cmd, $3); strcat(cmd, ")\n"); 
    $$ = cmd;
  }
  | ZERA '(' ID ')' 
	{
    char* cmd = malloc(strlen($1) + strlen($3) + 5); strcpy(cmd, $1); strcat(cmd, "(");
    strcat(cmd, $3); strcat(cmd, ")\n"); 
    $$ = cmd;
  }
	| SE ID ENTAO cmds FIM 
	{
		char *cmd = malloc(64 + strlen($1) + strlen($2) + strlen($3) + strlen($4) + strlen($5));
		strcpy(cmd,"BOOL1 = "); strcat(cmd,$2); strcat(cmd,"\nENQUANTO BOOL1 FACA\n");
		strcat(cmd,$4);strcat(cmd,"ZERA(BOOL1)\n");strcat(cmd,"FIM\n"); $$ = cmd;
		
	}
	| FACA ID VEZES cmds FIM 
	{
		char* cmd = malloc(64 + strlen($1) + strlen($2) + strlen($3) + strlen($4) + strlen($5));
		strcpy(cmd,"COUNTER = "); strcat(cmd,$2);strcat(cmd,"\nENQUANTO COUNTER "); strcat(cmd,"FACA\n"); strcat(cmd,$4);strcat(cmd,"DEC(COUNTER)\n");strcat(cmd,"FIM\n");
		$$ = cmd;
		
	}
	 | DEC '(' ID ')' 
	{
    char* cmd = malloc(strlen($1) + strlen($3) + 5); strcpy(cmd, $1); strcat(cmd, "(");
    strcat(cmd, $3); strcat(cmd, ")\n"); 
    $$ = cmd;
  }
;

%%


int main (int argc, char** argv) {
  if (argc > 1) {
    yyin = fopen(argv[1], "r");
  }
  yyparse();
  if (argc > 1) {
    fclose(yyin);
  }

  return(0);
}
