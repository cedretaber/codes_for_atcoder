import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "to", long, "d");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    Path[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto lrd = readln.split.to!(int[]);
        auto L = lrd[0]-1;
        auto R = lrd[1]-1;
        auto D = lrd[2];
        G[L] ~= Path(R, D);
        G[R] ~= Path(L, -D);
    }
    auto ds = new long[](N);
    auto fs = new bool[](N);
    bool ng;
    void solve(int i, int p, long d) {
        if (fs[i]) {
            if (ds[i] != d) ng = true;
        } else {
            ds[i] = d;
            fs[i] = true;
            foreach (n; G[i]) if (n.to != p) solve(n.to, i, d + n.d);
        }
    }
    foreach (i; 0..N) if (!fs[i]) solve(i, -1, 0);
    writeln(ng ? "No" : "Yes");
}