#include <iostream>
#include <fstream>
#include <string>
#include "parser.tab.h"
#include "lex.yy.h"

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

    yyparse();
    return 0;
}