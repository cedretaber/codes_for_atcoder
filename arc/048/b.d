import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias RN = Tuple!(int, "r", int, "h");

int[10^^5+1][3] GCP;
RN[10^^5] RNS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto rn = readln.split.to!(int[]);
        auto r = rn[0];
        auto n = rn[1]-1;
        ++GCP[n][r];
        RNS[i] = RN(r, n);
    }
    foreach (i; 0..10^^5) {
        foreach (j; 0..3) {
            GCP[j][i+1] += GCP[j][i];
        }
    }
    foreach (rn; RNS[0..N]) {
        int w;
        foreach (j; 0..3) w += GCP[j][rn.r-1];
        w += GCP[(rn.h+1)%3][rn.r] - GCP[(rn.h+1)%3][rn.r-1];
        auto d = GCP[rn.h][rn.r] - GCP[rn.h][rn.r-1] - 1;
        writefln("%d %d %d", w, N-w-d-1, d);
    }
}