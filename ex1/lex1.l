%option noyywrap

%{
	# include <stdio.h>
	# include <stdlib.h>
	# include <string.h>
%}

spc [ ]+
letter [a-zA-Z]
digit [0-9]
spl [;,.(){}\[\]]

%%
{spl} {printf("%s  Special Character\n", yytext);}
\".*\" {printf("%s  Character Constant\n", yytext);}
[\+\-\*\/%] {printf("%s  Arithmetic Operator\n", yytext);}
\+=|\-=|\*=|\/=|%= {printf("%s  Arithmetic Assignment Operator\n", yytext);}
&&|\|\||! {printf("%s  Logical Operator\n", yytext);}
\<|\<=|\>|\>=|==|!= {printf("%s  Relational Operator\n", yytext);}
\^|&|\||<<|>> {printf("%s  Bitwise Operator\n", yytext);}
\+\+|\-\-|\- {printf("%s  Unary Operator\n", yytext);}
= {printf("%s  Assignment Operator\n", yytext);}
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while {printf("%s  Keyword\n", yytext);}
[a-zA-Z][a-zA-Z0-9]*\([^\(\)]*\) {printf("%s  Function\n", yytext);}
[a-zA-Z][a-zA-Z0-9]* {printf("%s  Identifier\n", yytext);}
{digit}+ {printf("%s  Integer Constant\n", yytext);}
[ \t\n] {}
%%

int main() {
	FILE *f = fopen("src2.txt", "r");
	if (f)
	{
		yyin = f;
	}
	yylex();
	return 0;
}
