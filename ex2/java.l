%{
    # include <stdio.h>
    # include <stdlib.h>
    # include <string.h>
%}

DIGIT [0-9]
LETTER [a-zA-Z]
COMMENT \/\/.*
MULTICOMMENT \/\*[^(\*\/)]*\*\/
LIBRARY import(.*)
KEYWORD class|static|extends|implements|interface|"else if"|if|else
DATATYPE int|float|double|long|void|String
SPECIFIER public|private|protected
SPECIAL \.|,|;|\{|\}|\(|\)|\[|\]
ARITHMETIC \+|-|\*|\/|%
ASSIGN =|\+=|-=|\*=|\/=|%=|\+\+|--
RELATIONAL >|<|==|>=|<=|!=|!
LOOPING for|while
IDENTIFIER {LETTER}({DIGIT}|{LETTER})*
FUNCTION {LETTER}({DIGIT}|{LETTER})*\(.*\)|({LETTER}({DIGIT}|{LETTER})*\.)*{LETTER}({DIGIT}|{LETTER})*\(.*\)

%%
{COMMENT} {printf("\nSingle-line Comment: %s\n", yytext);}
{MULTICOMMENT} {printf("\nMulti-line Comment: %s\n", yytext);}
{LIBRARY} {printf("\nLibrary: %s\n", yytext);}
{KEYWORD} {printf("\nKeyword: %s\n", yytext);}
{DATATYPE} {printf("\nDatatype: %s\n", yytext);}
{SPECIFIER} {printf("\nAccess Specifier: %s\n", yytext);}
{SPECIAL} {printf("\nSpecial Char: %s\n", yytext);}
{ARITHMETIC} {printf("\nArithmetic Operator: %s\n", yytext);}
{ASSIGN} {printf("\nAssignment Operator: %s\n", yytext);}
{RELATIONAL} {printf("\nRelational Operator: %s\n", yytext);}
{LOOPING} {printf("\nLooping: %s\n", yytext);}
{IDENTIFIER} {printf("\nIdentifier: %s\n", yytext);}
{FUNCTION} {printf("\nFunction: %s\n", yytext);}
\".*\" {printf("\nString Constant: %s\n", yytext);}
{DIGIT}+\.{DIGIT}+ {printf("\nDecimal Constant: %s\n", yytext);}
{DIGIT}+ {printf("\nInteger Constant: %s\n", yytext);}
[ \n\t] {}
%%

int yywrap() {return 0;}

void main() {
    FILE *f = fopen("src3.txt", "r");
    if (f) {
   	 yyin = f;
    }
    yylex();
    fclose(f);
    return;
}
