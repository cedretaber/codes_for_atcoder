import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hwkv = readln.split.to!(long[]);
    auto H = hwkv[0];
    auto W = hwkv[1];
    auto K = hwkv[2];
    auto V = hwkv[3];

    auto CS = new long[][](H, W);
    foreach (i; 0..H) {
        foreach (j, a; readln.split.to!(long[])) {
            if (i > 0) a += CS[i-1][j];
            if (j > 0) a += CS[i][j-1];
            if (i > 0 && j > 0) a -= CS[i-1][j-1];
            CS[i][j] = a;
        }
    }
    long r;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            foreach (y; i..H) {
                foreach (x; j..W) {
                    auto v = (y-i+1) * (x-j+1) * K + CS[y][x];
                    if (i > 0) v -= CS[i-1][x];
                    if (j > 0) v -= CS[y][j-1];
                    if (i > 0 && j > 0) v += CS[i-1][j-1];
                    if (v <= V) r = max(r, (y-i+1) * (x-j+1));
                }
            }
        }
    }
    writeln(r);
}