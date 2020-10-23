%option noyywrap

%{
#include "scanner.h"

YYSTYPE yylval;
%}

%x COMMENT

WHITESPACE          ([[:space:]]+)
COMMENT_LINE        ("//"[^\n]*)
COMMENT_START       ("/*")
COMMENT_END         ("*/")
ID                  ([A-Za-z][A-Za-z0-9_]*)
DEC_INTEGER         ([0-9]+)
HEX_INTEGER         (0[xX][0-9A-Fa-f]+)
INTEGER             ({DEC_INTEGER}|{HEX_INTEGER})
STRING              (\"[^"\n]*\")
EXPONENT            ([Ee][+-]?{DEC_INTEGER})
DOUBLE              ([0-9]+\.[0-9]*{EXPONENT}?)
SYMBOLS             ([-+/*%=.,;!<>()[\]{}])


%%


{WHITESPACE}                {;}

{COMMENT_LINE}              {;}
{COMMENT_START}             { BEGIN(COMMENT); }
<COMMENT>{COMMENT_END}      { BEGIN(0); }
<COMMENT>.                  {;}

"void"              { return T_Void;}
"int"               { return T_Int; }
"double"            { return T_Double; }
"bool"              { return T_Bool; }
"string"            { return T_String; }
"class"             { return T_Class; }
"interface"         { return T_Interface; }
"null"              { return T_Null; }
"this"              { return T_This; }
"extends"           { return T_Extends; }
"implements"        { return T_Implements; }
"for"               { return T_For; }
"while"             { return T_While; }
"if"                { return T_If; }
"else"              { return T_Else; }
"return"            { return T_Return; }
"break"             { return T_Break; }
"continue"          {return T_Continue;}
"new"               { return T_New; }
"NewArray"          { return T_NewArray; }
"Print"             { return T_Print; }
"ReadInteger"       { return T_ReadInteger; }
"ReadLine"          { return T_ReadLine; }
"dtoi"              {return T_Dtoi;}
"itod"              {return T_Itod;}
"btoi"              {return T_Btoi;}
"itob"              {return T_Itob;}
"private"           {return T_Private;}
"protected"         {return T_Protected;}
"public"            {return T_Public;}

"<="                { return T_LessEqual; }
">="                { return T_GreaterEqual; }
"=="                { return T_Equal; }
"!="                { return T_NotEqual; }
"&&"                { return T_And; }
"||"                { return T_Or; }
{SYMBOLS}           { return yytext[0];} //no TokenType for these

"true"              { yylval.booleanLiteral = (yytext[0]=='t'); return T_BOOLEANLITERAL; }
"false"             { yylval.booleanLiteral = (yytext[0]=='t'); return T_BOOLEANLITERAL; }
{DEC_INTEGER}       { yylval.integerLiteral = strtol(yytext, NULL, 10); return T_INTLITERAL; }
{HEX_INTEGER}       { yylval.integerLiteral = strtol(yytext, NULL, 16); return T_INTLITERAL; }
{DOUBLE}            { yylval.doubleLiteral = strtod(yytext, NULL); return T_DOUBLELITERAL; }
{STRING}            { yylval.stringLiteral = strdup(yytext); return T_STRINGLITERAL; }

{ID}                { yylval.id = strdup(yytext); return T_ID; }

.                   { return UNDEFINED_TOKEN; }

%%

