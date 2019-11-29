import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

bool[12][12] F;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..N) F[i][i] = true;
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0] - 1;
        auto y = xy[1] - 1;
        F[x][y] = true;
        F[y][x] = true;
    }

    int r = 1;
    for (uint s; s < 2^^N; ++s) {
        foreach (i; 0..N) {
            foreach (j; 0..N) {
                if ( ((s&(1<<i)) == 0) || ((s&(1<<j)) == 0) ) continue;
                if (!F[i][j]) goto ng;
            }
        }
        r = max(r, popcnt(s));
        ng:
    }
    writeln(r);
}