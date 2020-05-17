%{
#include <stdio.h>
#include "y.tab.h"
%}

%option yylineno


%x COMMENTS
%%
([0-9]*\.[0-9]+)     {yylval.number=atof(yytext); return INTEGER; 
}
\"([^\\\"]|\\.)*\"  	                  	{return STRING;}
"true"						{return TRUE1 ;}
"false"						{return FALSE1;}
       

"int"            				  {return INT;}  
"float"						{return FLOAT;}
"boolean"					{return BOOLEAN;}
"String"					{return STRING_TYPE;}
"char"						{return CHAR;}

"end"                                {return EXIT_PROGRAM;}

"if"            				{return IF;} 
"else"						{return ELSE;}

"for"            				{return FOR;}
"loopEnd"					{return FOREND;}
"System.print"                			 {return PRINT;}
"scan"						{return SCAN;}
"func"						{return FUNC;}
"public"					{return PUBLIC;}
"static"        				{return STATIC;}
"void"            				{return VOID;}
"main"						{return MAIN;}
"try"                  				{ return TRY;}
"catch"               				 { return CATCH;}


[ \t\n]		        ;
"#".*			;
"/*"			{BEGIN(COMMENTS);}
<COMMENTS>"*/"		{;BEGIN(INITIAL);}
<COMMENTS>.		;


"throw"                				 {return THROW;}
"Exception"            				 {return EXCEPTION;}
"import"						{return IMPORT;}
"class"							{return CLASS;}
"package"						{return PACKAGE;}

[a-zA-Z_]([a-zA-Z_]|[0-9])*	{yylval.string=strdup(yytext); return (IDENTIFIER) ;}
[0-9]+		{yylval.number=atoi(yytext); return NUMBER; 
}

[a-zA-Z_]?'(\\.|[^\\'\n])+'	{return CONSTANT;}
([+-]?[0-9]*(\.)[0-9]+) 		{yylval.number=atoi(yytext); return NUM;
}


"+="            			{return ADD_ASSIGN;}
"-="            			{return SUB_ASSIGN ;}
"*="           				{return MUL_ASSIGN;} 
"/="            			{return DIV_ASSIGN;} 
"++"            			{return INCR;}
"--"               			{return DECR;}
"&&"               			{return AND; }
"||"            			{return OR;} 
"!="            			{return NOT_EQ;} 
"("		 			{return BRACKET_OPEN;}
")"		 			{return BRACKET_CLOSE;}
"{" 		 			{return CURLY_BRACE_OPEN;}
"}" 		 			{return CURLY_BRACE_CLOSE;}
"[" 		 			{return BIG_BRACKET_OPEN;}
"]"		 			{return BIG_BRACKET_CLOSE;}
"+"		 			{return PLUS;}
"*" 		 			{return MUL;}
"/"	         			{return DIVIDE;}
"-"		 			{return MINUS;}
"<"		 			{return LESS;}
">" 		 			{return GREATER;}
","         	 			{return COMMA;}
"<="		 			{return LESS_OR;}
">="		 			{return GREATER_OR;}
"=="		 			{return DEQ;}
":"              			{return TWO_DOT;}
"="            				{return EQUAL;} 
"."            				{return DOT;} 

"!"            				{return NOT;} 
"%"            				{return MOD;}

";"            				{return SEMICOLON;}
.            		;
%%

