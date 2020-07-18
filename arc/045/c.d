import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias E = Tuple!(uint, "to", uint, "c");

void main()
{
    auto nx = readln.split.to!(uint[]);
    auto N = nx[0];
    auto X = nx[1];
    auto T = new E[][N];
    foreach (_; 1..N) {
        auto xyc = readln.split.to!(uint[]);
        auto x = xyc[0]-1;
        auto y = xyc[1]-1;
        auto c = xyc[2];
        T[x] ~= E(y, c);
        T[y] ~= E(x, c);
    }
    long[uint] DP;
    long r;
    void walk(uint i, uint p, uint s) {
        if ((s^X) in DP) r += DP[s^X];
        DP[s] += 1;
        foreach (n; T[i]) if (n.to != p) walk(n.to, i, s^n.c);
    }
    walk(0, N, 0);
    writeln(r);
}