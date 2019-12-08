import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[][] G;
    G.length = N;
    foreach (i; 0..N) {
        foreach (j, c; readln.split.to!(int[])) if (c == 1) {
            G[i] ~= j.to!int;
        }
    }
}