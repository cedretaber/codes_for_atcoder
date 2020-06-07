import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];

    auto G = new int[][N];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }

    auto CS = readln.split.to!(int[]);

    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        auto x = q[1]-1;
        if (q[0] == 1) {
            writeln(CS[x]);
            foreach (y; G[x]) CS[y] = CS[x];
        } else {
            auto y = q[2];
            writeln(CS[x]);
            CS[x] = y;
        }
    }
}