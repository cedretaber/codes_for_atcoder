import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = readln.split.to!(int[]);
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    auto qs = new long[](N);
    long walk(int i, int p) {
        long q = 1;
        foreach (j; T[i]) if (j != p) {
            q *= walk(j, i) + 1;
        }
        return qs[i] = q;
    }
    walk(0, -1);

    auto fs = new bool[](N);
    auto ps = new long[](N);
    auto rs = new long[](N);
    void solve(int i, int p) {
        ps[i] = p == -1 ? qs[i] : (ps[p] / (qs[i]+1) + 1) * qs[i];

        auto c = cs[i]-1;
        rs[c] += fs[c] ? qs[i] : ps[i];
        fs[c] = true;
        foreach (j; T[i]) if (j != p) solve(j, i);
    }
    solve(0, -1);
    writeln(qs);
    writeln(ps);

    foreach (r; rs) writeln(r);
}