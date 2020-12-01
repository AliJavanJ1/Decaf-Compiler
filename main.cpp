#include <iostream>
#include <fstream>
#include <string>
#include "parser.tab.h"
#include "lex.yy.h"

using namespace std;

ofstream output_file;

int main(int argc, char *argv[]) {
    if (argc < 5) {
        cerr << "Usage: " << argv[0] << " -i <input> -o <output>" << endl;
        return 1;
    }
    string input_file_path = argv[2];
    string output_file_path = argv[4];
    output_file = ofstream(output_file_path);
    yyin = fopen(input_file_path.c_str(), "r");

    if (yyparse() == 0){
        output_file << "OK";
    }
    return 0;
}

int yyerror(char *s)
{
    output_file << "Syntax Error";
    return 0;
}