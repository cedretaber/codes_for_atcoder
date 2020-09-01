import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nmtxy = readln.split.to!(int[]);
    auto N = nmtxy[0];
    auto M = nmtxy[1];
    auto T = nmtxy[2];
    auto X = nmtxy[3];
    auto Y = nmtxy[4];

    int[] PS;
    foreach (_; 0..M) PS ~= readln.chomp.to!int;

    auto ss = new int[][](N, M);
    auto es = new int[][](N, M);
    auto ws = new int[][](N, M);
    foreach (i; 0..N) foreach (j; 0..M) {
        ss[i][j] = -1;
        es[i][j] = -1;
    }

    foreach (_; 0..Y) {
        auto tnms = readln.split;
        auto s = tnms[$-1];
        auto tnm = tnms[0..$-1].to!(int[]);
        auto t = tnm[0];
        auto n = tnm[1]-1;
        auto m = tnm[2]-1;

        if (s == "open") {
            ss[n][m] = t;
        } else if (s == "correct") {
            es[n][m] = t;
        } else {
            if (es[n][m] != -1) continue;
            ++ws[n][m];
        }
    }

    foreach (i; 0..N) {
        int p;
        foreach (j; 0..M) {
            if (es[i][j] == -1) continue;
            p += max(X, PS[j] - (es[i][j] - ss[i][j]) - 120*ws[i][j]);
        }
        writeln(p);
    }
}