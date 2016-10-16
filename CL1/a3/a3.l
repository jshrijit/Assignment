%{
#include <stdio.h>
int line=1;

int errCount=0;
%}

%%

"/*"(.|\n)*"*/" {printf("%s is a comment\n",yytext);}
"//"(.)* {printf("%s is a comment\n",yytext);} 
"#include" {printf("%s is the preprocessor directive\n",yytext);fprintf(yyout,"%d\t%s\tPreprocessor directive\n",line,yytext);}

(printf) {printf("%s is the library function\n",yytext);fprintf(yyout,"%d\t%s\tlibrary function\n",line,yytext);}

scanf {printf("%s is the library function\n",yytext);fprintf(yyout,"%d\t%s\tlibrary function\n",line,yytext);}
scanf[^(] {printf("%s is the error\n",yytext);fprintf(yyout,"%d\t%s\terror\n",line,yytext);}
printf[^(] {printf("%s is the error\n",yytext);fprintf(yyout,"%d\t%s\terror\n",line,yytext);}
return |
for |
main {printf("%s is the keyword\n",yytext);fprintf(yyout,"%d\t%s\tKeyword\n",line,yytext);}
int |
float |
char {printf("%s is the datatype\n",yytext);fprintf(yyout,"%d\t%s\tDatatype\n",line,yytext);}
"<"((.)*.h)">" {printf("%s is the header file\n",yytext);fprintf(yyout,"%d\t%s\tHeader file\n",line,yytext);}
[><(){},;:.*&""/\\] {printf("%s is the symbol\n",yytext);fprintf(yyout,"%d\t%s\tSymbol\n",line,yytext);}
%d |
%s |
%f |
%c |
%u {printf("%s is the format specifier\n",yytext);fprintf(yyout,"%d\t%s\tFormat specifier\n",line,yytext);}
[A-Za-z_][A-Za-z0-9]* {printf("%s is the identifier\n",yytext);fprintf(yyout,"%d\t%s\tIdentifier\n",line,yytext);}
[0-9]+ {printf("%s is the number\n",yytext);fprintf(yyout,"%d\t%s\tNumber\n",line,yytext);}
[0-9][A-Za-z0-9]* {printf("%s is the illegal identifier\n",yytext);fprintf(yyout,"%d\t%s\tillegal Identifier\n",line,yytext); errCount++;}
"+" |
"-" |
"*" |
"/" |
"++" |
"--" |
"+=" |
"-=" |
"*=" |
"/=" |
"=" |
"==" 				{
						printf("%s \t : \t is Operator !!\n", yytext);
						fprintf(yyout, "%d \t %s \t : Operator \n", line, yytext);
					}
"\n" {++line;}
" " |
"\t" ;
. 					{
						printf("%s \t : \t is Undefined character !!\n", yytext);
						fprintf(yyout, "%d \t %s \t\t : Undefined character \n", line, yytext);
						errCount++;
					};
%%

int main()
{
	yyin=fopen("myfile.c","r");
	yyout=fopen("myfile1.txt","w");
	fprintf(yyout,"line\tLexeme\tToken\n");
	
	yylex();
	fclose(yyin);
	
	printf("\n\nError Count : %d\n", errCount);
	return 1;
}

int yywrap()
{
	return 1;
}

void yyerror()
{
	printf("Error\n");
}
