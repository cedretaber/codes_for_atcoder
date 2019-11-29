import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias Path = Tuple!(int, "to", double, "m");

void main()
{
    auto N = readln.chomp.to!int;

    int[string] D;
    Path[][] G;
    int x;
    foreach (_; 0..N) {
        auto l = readln.split;
        auto a = l[0];
        auto m = l[1].to!double;
        auto b = l[2];

        if (a !in D) D[a] = x++;
        if (b !in D) D[b] = x++;
        auto i = D[a];
        auto j = D[b];
        if (G.length < x) G.length = x;
        if (i != j) {
            G[i] ~= Path(j, m);
            G[j] ~= Path(i, 1.0/m);
        }
    }
    string[] RD;
    RD.length = x;
    foreach (k, v; D) RD[v] = k;

    bool[] F;
    F.length = x;
    int A, B;
    double minm = int.max, maxm = 0;
    void solve(int i, double m) {
        F[i] = true;
        if (m < minm) {
            minm = m;
            A = i;
        }
        if (m > maxm) {
            maxm = m;
            B = i;
        }
        foreach (j; G[i]) if (!F[j.to]) {
            solve(j.to, m * j.m);
        }
    }
    solve(0, 1);

    writefln("1%s=%d%s", RD[A], (maxm / minm + 0.1).to!int, RD[B]);
}