#ifndef UNTITLED1_SCANNER_H
#define UNTITLED1_SCANNER_H

typedef enum {
    T_ID = 256, T_INTLITERAL, T_DOUBLELITERAL, T_STRINGLITERAL, T_BOOLEANLITERAL,
    T_Void, T_Int, T_Double, T_Bool, T_String, T_Class, T_Interface, T_Null, T_This, T_Extends,
    T_Implements, T_For, T_While, T_If, T_Else, T_Return, T_Break, T_Continue, T_New, T_NewArray, T_Print,
    T_ReadInteger, T_ReadLine, T_Dtoi, T_Itod, T_Btoi, T_Itob, T_Private, T_Protected, T_Public,
    T_LessEqual, T_GreaterEqual, T_Equal, T_NotEqual, T_And, T_Or,
    UNDEFINED_TOKEN,
    TOKENCOUNT
} TokenType;

static const char *TokenNames[TOKENCOUNT] = {
        "T_ID", "T_INTLITERAL", "T_DOUBLELITERAL", "T_STRINGLITERAL", "T_BOOLEANLITERAL",
        "T_Void", "T_Int", "T_Double", "T_Bool", "T_String", "T_Class", "T_Interface", "T_Null", "T_This", "T_Extends",
        "T_Implements", "T_For", "T_While", "T_If", "T_Else", "T_Return", "T_Break", "T_Continue", "T_New",
        "T_NewArray", "T_Print",
        "T_ReadInteger", "T_ReadLine", "T_Dtoi", "T_Itod", "T_Btoi", "T_Itob", "T_Private", "T_Protected", "T_Public",
        "T_LessEqual", "T_GreaterEqual", "T_Equal", "T_NotEqual", "T_And", "T_Or",
        "UNDEFINED_TOKEN",
        "TOKENCOUNT"
};

/** filled but not used in phase 1 cause yytext is the only thing we need to know about a token. */
typedef union {
    int integerLiteral;
    bool booleanLiteral;
    char *stringLiteral;
    double doubleLiteral;
    char *id;
} YYSTYPE;

extern YYSTYPE yylval;
extern char *yytext;
extern FILE *yyin, *yyout;

extern int yylex();

#endif //UNTITLED1_SCANNER_H
