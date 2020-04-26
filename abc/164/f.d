import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = readln.split.to!(int[]);
    auto ts = readln.split.to!(int[]);
    auto us = readln.split.to!(ulong[]);
    auto vs = readln.split.to!(ulong[]);

    auto M = new ulong[][](N, N);
    foreach (i, s; ss) if (s == 0) {
        foreach (j; 0..N) M[i][j] |= us[i];
    }
    foreach (j, t; ts) if (t == 0) {
        foreach (i; 0..N) M[i][j] |= vs[j];
    }

    auto X = new bool[][](N, N, 64);
    foreach ()


    writeln(M);
}