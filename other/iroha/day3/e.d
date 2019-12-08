import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    char[] CS;
    CS.length = N;
    foreach (i; 0..N) CS[i] = readln.chomp[0];

    int x = -1, r;
    foreach (i, c; CS) {
        switch (c) {
            case '/':
                if (i == 0 || CS[i-1] == '\\') {
                    x = 1;
                } else {
                    ++x;
                }
                break;
            case '\\':
                --x;
                if (x == 0 && (i+1 == CS.length || CS[i+1] == '/')) {
                    ++r;
                }
                break;
            default:
        }
    }
    writeln(r);
}