import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!(char[]);
    long N = A.length;
    long[char] CNT;
    foreach (a; A) {
        if (a !in CNT) CNT[a] = 0;
        ++CNT[a];
    }

    long r = N * (N-1) / 2 + 1;
    foreach (_, c; CNT) {
        r -= (c * (c-1) / 2);
    }
    writeln(r);
}