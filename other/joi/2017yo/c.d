import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmd = readln.split.to!(int[]);
    auto N = nmd[0];
    auto M = nmd[1];
    auto D = nmd[2];
    char[][] MAP;
    MAP.length = N;
    foreach (i; 0..N) MAP[i] = readln.chomp.to!(char[]);

    int r;
    foreach (i; 0..N) {
        foreach (j; 0..M) {
            int v = 1, h = 1;
            foreach (k; 0..D) {
                if (i+k >= N || MAP[i+k][j] == '#') --v;
                if (j+k >= M || MAP[i][j+k] == '#') --h;
            }
            r += max(0, v) + max(0, h);
        }
    }
    writeln(r);
}