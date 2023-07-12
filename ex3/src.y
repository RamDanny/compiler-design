%{

# include <stdio.h>

# include <stdlib.h>

# include <string.h>

# include <unistd.h>

# include <fcntl.h>

int yylex(void);

extern FILE* yyin;

#include "y.tab.h"

int error = 0;

extern int line;

%}



%token comment

%token multicomment

%token class

%token datatype

%token specifier

%token arithmetic

%token assign

%token relational

%token forloop

%token whileloop

%token ifs

%token elses

%token ret

%token identifier

%token function

%token strconst

%token numconst

%token array



%%

start:	class identifier '{' longfn '}'

;

longfn:	fn longfn

	|	fn

	;

fn:	specifier datatype function '{' longstmt '}'

;

longstmt:	statement ';' longstmt

		|	statement ';'

		;

statement:	identifier '(' expr ')'

		|	forloop '(' statement ';' expr ';' statement ')' '{' longstmt '}'

		|	ret identifier

		|	condstmt

		|	assistmt

		;

condstmt:	ifs '(' expr ')' '{' longstmt '}' elses '{' longstmt '}'

		|	ifs '(' expr ')' '{' longstmt '}'

		;

assistmt:	datatype identifier assign expr

		|	identifier assign expr

		;

expr:	expr arithmetic expr

	|	expr relational expr

	|	expr ',' expr

	|	identifier '(' expr ')'

	|	identifier '[' identifier ']'

	|	identifier

	|	numconst

	|	array

	;

%%



int yyerror() {

	fprintf(stderr, "Invalid syntax!\nError at line: %d\n", line);

	printf("\n");

	error = 1;

	return 0;

}



int yywrap() {

	return 1;

}



void main(int argc, char** argv) {

	yyin = fopen(argv[1], "r");

	if(!yyin)

	{

		printf("File not found!\n");

		return;

	}

	yyparse();

	if(!error) {

		printf("\nNo errors found! Valid syntax!\n");

	}

	return;

}

