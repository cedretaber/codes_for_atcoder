import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    readln;
    auto s = readln.chomp;
    string k;
    string kk;
    int p;

    foreach (c; s) {
        switch (c) {
            case '(':
                if (!p++) {
                    kk ~= k;
                    k = "";
                }
                k ~= '(';
                break;
            case ')':
                if (p) {
                    --p;
                    k ~= ')';
                } else {
                    kk = '(' ~ kk;
                    k ~= ')';
                }
                break;
            default:
        }
    }
    while (p--) k ~= ')';

    writeln(kk ~ k);
}