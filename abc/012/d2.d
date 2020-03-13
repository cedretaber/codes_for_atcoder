import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto G = new long[][](N, N);
    foreach (i, ref g; G) {
        g[] = long.max/3;
        g[i] = 0;
    }
    foreach (_; 0..M) {
        auto abt = readln.split.to!(int[]);
        auto a = abt[0]-1;
        auto b = abt[1]-1;
        long t = abt[2];
        G[a][b] = t;
        G[b][a] = t;
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (G[i][j] > G[i][k] + G[k][j]) G[i][j] = G[i][k] + G[k][j];
    }
    auto r = long.max;
    foreach (i; 0..N) {
        long rr;
        foreach (j; 0..N) rr = max(rr, G[i][j]);
        r = min(r, rr);
    }
    writeln(r);
}