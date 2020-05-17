%{
#include <stdio.h>
#include<stdbool.h>
#include"lex.yy.c"
#include<string.h>

void sys();
int hat(char *);
void yyerror (char const *);
int check(int, int, int);
void scan(char *argv[]);

char error[55] = "Error";
extern int yylineno;
int loc =-1;
int lid =-1;
 
struct types
{
    char idName[50];
    int value;
    int type; 
    int line_no;
    int scope;
};

struct types st[50];
%}

%union
{
    	int number;
    	char *string;

}

%token <number> NUMBER INTEGER
%token <number> NUM FLOAT_T
%token <string> IDENTIFIER

%type<number> arithm_e

%type<string> ids1
%type<string> ids2
%type<string> ids3
%type<number> relational_exp



%token CONSTANT STRING INCR DECR LESS_OR GREATER_OR EQUAL NOT_EQ DEQ
%token AND OR MUL_ASSIGN DIV_ASSIGN MOD ADD_ASSIGN SUB_ASSIGN  STATIC
%token CHAR INT FLOAT  VOID IF ELSE FOR    TRUE1 FALSE1 BOOLEAN TRY CATCH THROW EXCEPTION EXIT_PROGRAM SCAN FUNC
%token IMPORT CLASS PACKAGE MAIN STRING_TYPE  PUBLIC PRINT
%token BRACKET_OPEN BRACKET_CLOSE CURLY_BRACE_OPEN CURLY_BRACE_CLOSE BIG_BRACKET_OPEN BIG_BRACKET_CLOSE FOREND
%token PLUS MINUS MUL DIVIDE LESS GREATER COMMA TWO_DOT DOT  NOT    SEMICOLON




%nonassoc EQUAL
%left PLUS MINUS MUL DIVIDE

%right LESS GREATER  NE LESS_OR GREATER_OR DEQ

%%
prog: stmts 

  ;
stmts: package_statement import_statement block_stmt
             	;

   		  ;

class_name: IDENTIFIER
    	;
block_stmt: PUBLIC CLASS class_name CURLY_BRACE_OPEN main_method method CURLY_BRACE_CLOSE 
             
      	;
method_name:IDENTIFIER
	;
main_method: PUBLIC STATIC VOID MAIN BRACKET_OPEN BRACKET_CLOSE  exception_handling  body
       	;
method: FUNC  method_name BRACKET_OPEN BRACKET_CLOSE  body
	|
	;
body: CURLY_BRACE_OPEN sl  CURLY_BRACE_CLOSE
	;

sl: sl s1
  |
  ;


s1:  nonblock_stmt 
  	|block_st2 
	| SEMICOLON
	| method_name BRACKET_OPEN BRACKET_CLOSE
	
	
	;

nonblock_stmt: variable_declaration SEMICOLON
		|expr SEMICOLON
		|single_stmt
		;
single_stmt:print_stmt
		|scan_stmt
		|end_stmt
		;

block_st2: if_stmt         
	|for_stmt 
        | try_stmt
	;

variable_declaration: datatypes
			|text_type
                	;
text_type: STRING_TYPE
	    |CHAR
	    ;
datatypes: INT ids1
    	| FLOAT  ids2
    | BOOLEAN  ids3
	|STRING_TYPE ids4
    	;

ids1: IDENTIFIER EQUAL arithm_e    {if(hat($1)==-1){lid++; strcpy(st[lid].idName,$1); st[lid].type =0; st[lid].value = $3;} }
   | ids1 COMMA IDENTIFIER    {if(hat($3)==-1) {lid++; strcpy(st[lid].idName,$3);  st[lid].type =0; } else {yyerror(error);} }
   | IDENTIFIER    	 {if(hat($1)==-1) {lid++; strcpy(st[lid].idName,$1); st[lid].type =0; } }
   | IDENTIFIER EQUAL relational_exp    {loc = hat($1);  if(loc==-1) {lid++; strcpy(st[lid].idName,$1); st[lid].type =3; st[lid].value = $3;} else { st[loc].value = $3; } }
   ;

ids2: IDENTIFIER EQUAL arithm_e	{if(hat($1)==-1) {lid++; strcpy(st[lid].idName,$1); st[lid].type =1; st[lid].value = $3;} }
   | ids2 COMMA IDENTIFIER    {if(hat($3)==-1) { lid++; strcpy(st[lid].idName,$3);  st[lid].type =1; } else {yyerror(error);}}
   | IDENTIFIER   		 {if(hat($1)==-1) {lid++; strcpy(st[lid].idName,$1);  st[lid].type =1; }}
   ;

ids3: IDENTIFIER EQUAL relational_exp    {if(hat($1)==-1) {lid++; strcpy(st[lid].idName,$1); st[lid].type =3; st[lid].value = $3;} else { st[loc].value = $3; } }
  
   | IDENTIFIER    	 {if(hat($1)==-1) {lid++; strcpy(st[lid].idName,$1); st[lid].type =3; } }
   ;

ids4: IDENTIFIER EQUAL   STRING  {printf("\tValue\t\n");
printf("%s",yytext);
}
	;

expr: arithm_e
         | relational_exp
      	;

relational_exp: arithm_e LESS arithm_e   	 {$$ = check($1,$3,1);}
      	| arithm_e GREATER arithm_e 	 {$$ = check($1,$3,2);}
      	| arithm_e LESS_OR arithm_e 	 {$$ = check($1,$3,3);}
      	| arithm_e GREATER_OR arithm_e 	 {$$ = check($1,$3,4);}
      	| arithm_e DEQ arithm_e     {$$ = check($1,$3,5);}
      	| arithm_e NOT_EQ arithm_e     {$$ = check($1,$3,6);}
	| arithm_e AND arithm_e		{$$ = check($1,$3,7);}
	| arithm_e OR arithm_e		{$$ = check($1,$3,8);}
      | IDENTIFIER EQUAL relational_exp     {loc = hat($1);if(loc!=-1) { st[loc].value = $3; } else { yyerror(error);}}
      	| TRUE1   		 {$$=1;}
      	| FALSE1   		 {$$=0;}
      	;

arithm_e: arithm_e MUL arithm_e   	 {$$ = $1 * $3;}
     | arithm_e DIVIDE arithm_e    {$$ = $1 / $3;}
     | arithm_e PLUS arithm_e    { $$ = $1 + $3;}
     | arithm_e MINUS arithm_e    {$$ = $1 - $3;}
     | IDENTIFIER   		{loc = hat($1); if(loc!=-1) { $$ = st[loc].value; } else {yyerror(error);} }
     | NUMBER   			 {$$ =  $1; }
    | FLOAT_T                   {$$=$1;}
     | INTEGER   		 {$$ =  $1; }
     | IDENTIFIER INCR   	 {loc = hat($1); $$=st[loc].value+1;}
     | IDENTIFIER DECR   	 {loc = hat($1); $$=st[loc].value-1;}
     | INCR IDENTIFIER    	 {loc = hat($2); $$=st[loc].value+1;}
     | DECR IDENTIFIER    	 {loc = hat($2); $$=st[loc].value-1;}
     | IDENTIFIER EQUAL arithm_e    {loc = hat($1); if(loc!=-1) { st[loc].value = $3; } else {yyerror(error);}}
	  
	;


     ;


if_stmt: IF BRACKET_OPEN relational_exp BRACKET_CLOSE body   		 
   	| IF BRACKET_OPEN relational_exp BRACKET_CLOSE body else_if_blocks
   
   	;

else_if_blocks :  ELSE else_if_block
           	| else_if_blocks  ELSE else_if_block
           	;

else_if_block : IF BRACKET_OPEN relational_exp BRACKET_CLOSE body
      	| body
          	;

for_stmt: FOR BRACKET_OPEN for_args BRACKET_CLOSE beden
    	;
beden: CURLY_BRACE_OPEN state_loop  CURLY_BRACE_CLOSE
	;
state_loop: sl loop_stmt
		|
	;
loop_stmt: FOREND BRACKET_OPEN BRACKET_CLOSE SEMICOLON {
    int j=-1;
    printf("\nTime\tValue\t\n");
    for(j=0;j<=lid;j++)
    {    
	for(lid=0;lid<=st[j].value;lid++){

		printf("%s\t%d\t\n",st[j].idName,st[j].value);
		}
    }
printf("%s","LOOP");
}
	;

for_args: arg1 SEMICOLON arg2 SEMICOLON arg3  
   	;

arg1: variable_declaration
   	|expr
   	|
   	;


arg2: relational_exp
 	|
 	;

arg3:arithm_e
 	|
 	;
try_stmt : TRY CURLY_BRACE_OPEN try_m CURLY_BRACE_CLOSE
	;
try_m: CATCH CURLY_BRACE_OPEN  catch_m CURLY_BRACE_CLOSE
	;

catch_m: { void yyerror (char const *);}
	;
exception_handling : THROW EXCEPTION { void yyerror (char const *);}
		|                         
	;
package_statement: PACKAGE IDENTIFIER SEMICOLON
             	;
import_statement: IMPORT IDENTIFIER  DOT MUL SEMICOLON
   		  | IMPORT class_name SEMICOLON
                     	| IMPORT MUL SEMICOLON
                     	|
			;
print_stmt: PRINT BRACKET_OPEN BRACKET_CLOSE SEMICOLON {sys(); printf("\n BUILD SUCCESFUlL \n");}
	;
scan_stmt: SCAN BRACKET_OPEN BRACKET_CLOSE SEMICOLON {void scan(char *argv[]);}
	;
end_stmt: EXIT_PROGRAM {exit(0);}
	;

%%




int main()
{
yyparse();
return 1;

}


int hat(char *name)
{
    int j=-1;
    for(j=0;j<lid+1;j++)
    {
   	// printf("Found for:%s %s %d\n",name , st[j].idName ,  j);   	 
   	 if(strcmp(name, st[j].idName)==0)
   	 {    
   			 
   		 return j;
   	 }
    }
return -1;
}


void sys()
{
    int j=-1;
    printf("Name\tValue\t\n");
    for(j=0;j<=lid;j++)
    {    
		printf("%s\t%d\t\n",st[j].idName,st[j].value);		
    }
}

/*
void loop()
{
    int j=-1;
    printf("\nTime\tName\tValue\t\n");
    for(j=0;j<=lid;j++)
    {    
	for(lid=0;lid<=st[j].value;lid++){

		printf("%s\t%d\t\n",st[j].idName,st[j].value);
		}
    }
return lid;
}*/


int check(int a, int b, int k )
{

switch(k)
{
case 1: if (a<b)
    	return 1;
    	else
    	return 0;
    	break;

case 2: return (a>b);
     	break;
     	 
case 3: return (a<=b);
     	break;
     	 
case 4: return (a>=b);
     	break;
     	 
case 5: return (a==b);
     	break;
     	 
case 6: return (a!=b);
     	break;
case 7: return (a&&b);
     	break;
case 8: return (a||b);
     	break;

}
}      	 
 
void yyerror (char const *s)
{
fprintf (stderr, "%s\n", s);
  printf("Error occured at  Line No.  %d\n" , yylineno);
 
   printf("Error after : %s\n" , yytext);
 //exit(0);

}   
void scan(char *argv[]){

FILE *f1;
f1=fopen(argv[1],"w+");
yyout=f1;
fprintf(yyout,"%s",yytext);

} 	 
