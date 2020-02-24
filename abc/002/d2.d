import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;
import core.bitop;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto R = new bool[][](N, N);
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        R[x][y] = true;
        R[y][x] = true;
    }
    int r;
    foreach (x; 0..(1<<N)) {
        foreach (i; 0..N) if (x & (1<<i)) {
            foreach (j; i+1..N) if (x & (1<<j)) {
                if (!R[i][j]) goto ng;
            }
        }
        r = max(r, popcnt(x));
        ng:
    }
    writeln(r);
}