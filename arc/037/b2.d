import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        G[u] ~= v;
        G[v] ~= u;
    }
    auto memo = new bool[](N);
    bool run(int i, int p) {
        if (memo[i]) return false;
        memo[i] = true;
        foreach (j; G[i]) if (j != p) if (!run(j, i)) return false;
        return true;
    }
    int r;
    foreach (i; 0..N) if (run(i, -1)) ++r;
    writeln(r);
}