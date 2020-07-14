import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nml = readln.split.to!(int[]);
    auto N = nml[0];
    auto M = nml[1];
    long L = nml[2];
    auto G = new long[][](N, N);
    foreach (ref g; G) g[] = long.max/3;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto A = abc[0]-1;
        auto B = abc[1]-1;
        long C = abc[2];
        G[A][B] = C;
        G[B][A] = C;
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (G[i][j] > G[i][k] + G[k][j]) G[i][j] = G[i][k] + G[k][j];
    }

    auto H = new int[][](N, N);
    foreach (ref h; H) h[] = int.max/3;
    foreach (i; 0..N) foreach (j; 0..N) if (G[i][j] <= L) H[i][j] = 1;
    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (H[i][j] > H[i][k] + H[k][j]) H[i][j] = H[i][k] + H[k][j];
    }
    foreach (i; 0..N) foreach (j; 0..N) if (H[i][j] == int.max/3) H[i][j] = 0;

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto st = readln.split.to!(int[]);
        auto s = st[0]-1;
        auto t = st[1]-1;
        writeln(H[s][t]-1);
    }
}