import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias VDC = Tuple!(int, "v", int, "d", int, "c");

int[10^^5] MAX_D, COLS, MEMO;
int[][10^^5] G;
VDC[10^^5] QS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0] - 1;
        auto b = ab[1] - 1;
        G[a] ~= b;
        G[b] ~= a;
    }

    auto Q = readln.chomp.to!int;
    foreach_reverse (i; 0..Q) {
        auto vdc = readln.split.to!(int[]);
        QS[i] = VDC(vdc[0]-1, vdc[1]+1, vdc[2]);
    }

    void paint(int v, int d, int c) {
        if (MAX_D[v] >= d) return;
        MAX_D[v] = d;
        if (!COLS[v]) COLS[v] = c;
        foreach (w; G[v]) if (MAX_D[w] < d-1) paint(w, d-1, c);
    }

    foreach (q; QS) paint(q.v, q.d, q.c);

    foreach (i; 0..N) writeln(COLS[i]);
}