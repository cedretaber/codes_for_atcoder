import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    long[] DS;
    foreach (_; 0..N) DS ~= readln.chomp.to!long;
    int[][] G;
    G.length = N;
    foreach (_; 0..K) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        G[x] ~= y;
        G[y] ~= x;
    }
    long[ulong][] MEMO;
    MEMO.length = N;
    long walk(int i, ulong s) {
        if ((1uL<<i) & s) return 0;
        s |= 1uL<<i;
        if (s in MEMO[i]) return MEMO[i][s];
        long d;
        foreach (j; G[i]) if (!((1uL<<j) & s)) {
            d = max(d, walk(j, s));
        }
        return MEMO[i][s] = d + DS[i];
    }
    long r;
    foreach (i; 0..N) {
        r = max(r, walk(i, 0));
    }
    writeln(r);
}