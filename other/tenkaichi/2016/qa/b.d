import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] T;
    T.length = N;
    foreach (i; 1..N) {
        auto p = readln.chomp.to!int;
        T[p] ~= i;
    }
    auto CS = new long[](N);
    foreach (_; 0..M) {
        auto bc = readln.split.to!(long[]);
        CS[bc[0]] = bc[1];
    }

    long r;
    long solve(int i) {
        if (CS[i]) return CS[i];

        long[] ds;
        long mind = long.max;
        foreach (j; T[i]) {
            auto d = solve(j);
            ds ~= d;
            mind = min(mind, d);
        }
        foreach (d; ds) {
            r += d - mind;
        }
        return mind;
    }
    foreach (i; T[0]) r += solve(i);
    writeln(r);
}