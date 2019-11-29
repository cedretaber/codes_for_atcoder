import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2*10^^5] XS;

void main()
{
    auto ln = readln.split.to!(int[]);
    auto L = ln[0];
    auto N = ln[1];
    foreach (i; 0..N) {
        XS[i] = readln.chomp.to!int;
    }

    int i, j = N - 1, c;
    long r1, r2;

    r1 = XS[i];
    while (i != j) {
        if (c++ % 2) {
            r1 += XS[i++] + L - XS[j];
        } else {
            r1 += L - XS[j--] + XS[i];
        }
    }
    i = 0;
    j = N - 1;
    c = 0;
    r2 = L - XS[j];
    while (i != j) {
        if (c++ % 2) {
            r2 += L - XS[j--] + XS[i];
        } else {
            r2 += XS[i++] + L - XS[j];
        }
    }

    writeln([r1, r2]);
    writeln(max(r1, r2));
}

/*


2 -> 2+1 -> 1+7
1 -> 1+2 -> 2+3


*/