import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] CS;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto S = readln.chomp.to!(char[]);

    auto pre = 'T';
    foreach (i, c; S) {
        if (i) CS[i] = CS[i-1];
        if (pre == 'A' && c == 'C') ++CS[i];
        pre = c;
    }

    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        auto l = lr[0]-1;
        auto r = lr[1]-1;

        writeln(CS[r] - CS[l]);
    }
}