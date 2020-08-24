import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto bs = new int[][](K+2, K+2);
    auto ws = new int[][](K+2, K+2);
    foreach (_; 0..N) {
        auto xyc = readln.split;
        auto x = xyc[0].to!int;
        auto y = xyc[1].to!int;
        auto c = xyc[2];
        if ((c == "B" && (x/K + y/K)%2 == 0) || (c == "W" && (x/K + y/K)%2 == 1)) {
            bs[y%K+1][x%K+1] += 1;
        } else {
            ws[y%K+1][x%K+1] += 1;
        }
    }

    foreach (i; 1..K+1) foreach (j; 1..K+1) {
        bs[i][j] += bs[i-1][j];
        ws[i][j] += ws[i-1][j];
        bs[i][j] += bs[i][j-1];
        ws[i][j] += ws[i][j-1];
        bs[i][j] -= bs[i-1][j-1];
        ws[i][j] -= ws[i-1][j-1];
    }

    long r;
    foreach (i; 1..K+1) foreach (j; 1..K+1) {
        r = max(r, bs[K][K] - bs[i][K] - bs[K][j] + bs[i][j]*2 + ws[K][j] + ws[i][K] - ws[i][j]*2);
        r = max(r, ws[K][K] - ws[i][K] - ws[K][j] + ws[i][j]*2 + bs[K][j] + bs[i][K] - bs[i][j]*2);
    }
    writeln(r);
}