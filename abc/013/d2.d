import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nmd = readln.split.to!(long[]);
    auto N = nmd[0];
    auto M = nmd[1];
    auto D = nmd[2];
    auto as = 0.iota(N).array;
    foreach (i, ref a; as) a = i.to!int;
    foreach (a; readln.split.to!(int[])) swap(as[a-1], as[a]);
    auto rs = new int[][](30, N);
    foreach (i, a; as) rs[0][a] = i.to!int;
    foreach (i; 1..30) foreach (j; 0..N) rs[i][j] = rs[i-1][rs[i-1][j]];
    as = 0.iota(N).array;
    foreach (i; 0..30) if (D & (1L<<i)) {
        foreach (j; 0..N) as[j] = rs[i][as[j]];
    }
    foreach (a; as) writeln(a+1);
}