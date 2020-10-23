#include <iostream>
#include <fstream>
#include <string>
#include "scanner.h"

using namespace std;

int main(int argc, char *argv[]) {
    if (argc < 5) {
        cerr << "Usage: " << argv[0] << " -i <input> -o <output>" << endl;
        return 1;
    }
    string input_file_path = argv[2];
    string output_file_path = argv[4];
    ofstream output_file(output_file_path);
    yyin = fopen(input_file_path.c_str(), "r");


    TokenType token;
    while ((token = (TokenType) yylex())) {
        switch (token) {
            case T_ID:
                cout << TokenNames[token - 256] << " " << yytext << endl;
                output_file << TokenNames[token - 256] << " " << yytext << endl;
                break;
            case T_INTLITERAL:
                cout << TokenNames[token - 256] << " " << yytext << endl;
                output_file << TokenNames[token - 256] << " " << yytext << endl;
                break;
            case T_DOUBLELITERAL:
                cout << TokenNames[token - 256] << " " << yytext << endl;
                output_file << TokenNames[token - 256] << " " << yytext << endl;
                break;
            case T_STRINGLITERAL:
                cout << TokenNames[token - 256] << " " << yytext << endl;
                output_file << TokenNames[token - 256] << " " << yytext << endl;
                break;
            case T_BOOLEANLITERAL:
                cout << TokenNames[token - 256] << " " << yytext << endl;
                output_file << TokenNames[token - 256] << " " << yytext << endl;
                break;
            case UNDEFINED_TOKEN:
                cout << TokenNames[token - 256] << endl;
                output_file << TokenNames[token - 256] << endl;
                break;
            default:
                cout << yytext << endl;
                output_file << yytext << endl;
        }
    }
}