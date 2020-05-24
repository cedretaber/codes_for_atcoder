import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rcm = readln.split.to!(int[]);
    auto R = rcm[0];
    auto C = rcm[1];
    auto M = rcm[2];
    auto F = new int[][](R, C);
    auto N = readln.chomp.to!int;
    int[] ras, rbs, cas, cbs;
    foreach (_; 0..N) {
        auto rc = readln.split.to!(int[]);
        auto ra = rc[0] - 1;
        auto rb = rc[1] - 1;
        auto ca = rc[2] - 1;
        auto cb = rc[3] - 1;
        ras ~= ra;
        rbs ~= rb;
        cas ~= ca;
        cbs ~= cb;
        foreach (i; 0..R) foreach (j; 0..C) if (ra <= i && i <= rb && ca <= j && j <= cb) {
            (F[i][j] += 1) %= 4;
        }
    }
    foreach (k; 0..N) {
        auto ra = ras[k];
        auto rb = rbs[k];
        auto ca = cas[k];
        auto cb = cbs[k];
        foreach (i; 0..R) foreach (j; 0..C) if (ra <= i && i <= rb && ca <= j && j <= cb) {
            (F[i][j] += 3) %= 4;
        }
        int m;
        foreach (i; 0..R) foreach (j; 0..C) if (F[i][j] == 0) ++m;
        if (m == M) writeln(k+1);
        foreach (i; 0..R) foreach (j; 0..C) if (ra <= i && i <= rb && ca <= j && j <= cb) {
            (F[i][j] += 1) %= 4;
        }
    }
}