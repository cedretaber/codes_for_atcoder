import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }
    auto DS = new long[](N);
    foreach (_; 0..Q) {
        auto px = readln.split.to!(long[]);
        DS[px[0]-1] += px[1];
    }

    void solve(int i, int p, long s) {
        DS[i] += s;
        s = DS[i];
        foreach (j; T[i]) if (j != p) solve(j, i, s);
    }
    solve(0, -1, 0);

    writeln(DS.to!(string[]).join(" "));
}