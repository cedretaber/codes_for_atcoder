import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[14][14] DS;
long[uint][14] MEMO;
uint[14] BIND;

void main()
{
    auto N = readln.chomp.to!int;

    foreach (i; 0..N) {
        foreach (j, d; readln.split.to!(long[])) DS[i][j] = d;
    }
    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto st = readln.split.to!(int[]);
        auto s = st[0] - 1;
        auto t = st[1] - 1;
        BIND[t] |= (1<<s);
    }

    long solve(int i, uint s) {
        if (s == (1<<N)-1) return 0;
        if (s in MEMO[i]) return MEMO[i][s];
        auto r = long.max / 2;
        foreach (n; 0..N) {
            if (s & (1<<n)) continue;
            if ((s & BIND[n]) != BIND[n]) continue;
            r = min(r, solve(n, s | (1<<n)) + DS[i][n]);
        }
        return MEMO[i][s] = r;
    }
    writeln(solve(0, 1));
}