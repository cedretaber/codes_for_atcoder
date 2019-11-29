import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] G;
    G.length = N+1;
    foreach (_; 0..M) {
        auto st = readln.split.to!(int[]);
        auto s = st[0]-1;
        auto t = st[1]-1;
        G[s] ~= t;
    }

    double r = N*2;
    foreach (i; )
}