import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

int[18][18] ZS;

void main() {
    auto nmpqr = readln.split.to!(int[]);
    auto N = nmpqr[0];
    auto M = nmpqr[1];
    auto P = nmpqr[2];
    auto Q = nmpqr[3];
    auto R = nmpqr[4];

    foreach (_; 0..R) {
        auto xyz = readln.split.to!(int[]);
        auto x = xyz[0]-1;
        auto y = xyz[1]-1;
        auto z = xyz[2];
        ZS[x][y] = z;
    }

    int r;
    foreach (uint xs; 0..(1<<N)) {
        if (popcnt(xs) != P) continue;
        int[] ys;
        ys.length = M;
        foreach (i; 0..N) if (xs & (1<<i)) {
            foreach (j; 0..M) {
                ys[j] += ZS[i][j];
            }
        }
        sort!"a > b"(ys);
        int rr;
        foreach (i; 0..Q) rr += ys[i];
        r = max(r, rr);
    }
    writeln(r);
}