%{ 



#include <stdio.h> 



#include <ctype.h> 

#include "y.tab.h" 

extern int yylval; 

int yylex();



%}



identifier ([a-zA-Z][0-9])+|[a-zA-Z]+ 



%% 



^import\ java\.[^;]* {return IMPORT;}

class {return CLASS; }

public {return PUBLIC;} 

static {return STATIC; }

int {return INT; }

void {return VOID;} 

String {return STRING; }

"if" {return IF; }

"else" {return ELSE;} 

"for" {return FOR; }

"return" {return RETURN;} 

length {return LENGTH; }

{identifier} {return ID;}

System\.out\.print(ln)?\(.*\) {return PRINT; }

[0-9]+ {return NUMBER; }

[\n\t\ ]+ {;} 

. {return yytext[0]; }


%%

