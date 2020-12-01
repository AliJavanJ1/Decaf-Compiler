
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token T_ID T_INTLITERAL T_DOUBLELITERAL T_STRINGLITERAL T_BOOLEANLITERAL
           T_Void T_Int T_Double T_Bool T_String T_Class T_Interface T_Null T_This T_Extends
           T_Implements T_For T_While T_If T_Else T_Return T_Break T_Continue T_New T_NewArray T_Print
           T_ReadInteger T_ReadLine T_Dtoi T_Itod T_Btoi T_Itob T_Private T_Protected T_Public
           T_LessEqual T_GreaterEqual T_Equal T_NotEqual T_And T_Or
           UNDEFINED_TOKEN
           TOKENCOUNT

%type <id> T_ID
%type <integerLiteral> T_INTLITERAL
%type <doubleLiteral> T_DOUBLELITERAL
%type <stringLiteral> T_STRINGLITERAL
%type <booleanLiteral> T_BOOLEANLITERAL

%union{
    int integerLiteral;
    bool booleanLiteral;
    char *stringLiteral;
    double doubleLiteral;
    char *id;
}

%%

Program:
Decl
| Decl Program
;

Decl:
VariableDecl
| FunctionDecl
| ClassDecl
| InterfaceDecl
;

VariableDecls:
VariableDecl VariableDecls
|
;

VariableDecl:
Variable ';'
;

Variable:
Type T_ID
;

Type:
T_Int
| T_Double
| T_Bool
| T_String
| T_ID
| Type '[' ']'
;

FunctionDecl:
Type T_ID '(' Formals ')' StmtBlock
| T_Void T_ID '(' Formals ')' StmtBlock
;

Formals:
Variable FormalsContinue
|
;

FormalsContinue:
',' Variable Formals_Continue
|
;

ClassDecl:
T_Class T_ID Extends Implements '{' Fields '}'
;

Extends:
T_Extends T_ID
|
;

Implements:
T_Implements T_ID
|
;

ImplementsContinue:
',' T_Implements T_ID ImplementsContinue
|
;

Fields:
Field Fields
|
;

Field:
AccessMode VariableDecl
| AccessMode FunctionDecl
;

AccessMode :
T_Private
| T_Protected
| T_Public
|
;

InterfaceDecl:
T_Interface T_ID '{' Prototypes '}'
;

Prototypes:
Prototype Prototypes
|
;

Prototype:
Type T_ID '(' Formals ')' ';'
| T_Void T_ID '(' Formals ')' ';'
;

StmtBlock:
'{' VariableDecls Stmts '}'
;

Stmts:
Stmt Stmts
|
;

Stmt :
Expr ';'
| ';'
| IfStmt
| WhileStmt
| ForStmt
| BreakStmt
| ContinueStmt
| ReturnStmt
| PrintStmt
| StmtBlock
;

IfStmt:
T_If '(' Expr ')' Stmt ElseStmt
;

ElseStmt:
T_Else Stmt
|
;

WhileStmt:
T_While '(' Expr ')' Stmt
;

ForStmt:
T_For '(' ExprOrNot ';' Expr ';' ExprOrNot ')' Stmt
;

ReturnStmt:
T_Return ExprOrNot ';'
;

BreakStmt:
T_Break ';'
;

ContinueStmt:
T_Continue ';'
;

PrintStmt:
T_Print '(' Expr ExprContinue ')' ';'
;

Expr:
LValue '=' Expr
| Constant
| LValue
| T_This
| Call
| '(' Expr ')'
| Expr '+' Expr
| Expr '−' Expr
| Expr '∗' Expr
| Expr '/' Expr
| Expr '%' Expr
| '−' Expr
| Expr '<' Expr
| Expr T_LessEqual Expr
| Expr '>' Expr
| Expr T_GreaterEqual Expr
| Expr T_Equal Expr
| Expr T_NotEqual Expr
| Expr T_And Expr
| Expr T_Or Expr
| '!' Expr
| T_ReadInteger '(' ')'
| T_ReadLine '(' ')'
| T_New T_ID
| T_NewArray '(' Expr ',' Type ')'
| T_Itod '(' Expr ')'
| T_Dtoi '(' Expr ')'
| T_Itob '(' Expr ')'
| T_Btoi '(' Expr ')'
;

ExprContinue:
',' Expr ExprContinue
|
;

LValue:
T_ID
| Expr '.' T_ID
| Expr '[' Expr ']'
;

Call:
T_ID '(' Actuals ')'
| Expr '.' T_ID '(' Actuals ')'
;

Actuals:
Expr ExprContinue
|
;

Constant:
T_INTLITERAL
| T_DOUBLELITERAL
| T_BOOLEANLITERAL
| T_STRINGLITERAL
| T_Null
;

%%

int yyerror(char *s)
{
	printf("Semantic Error on line %s\n", s);
	return 0;
}

int main()
{
    yyparse();
    return 0;
}