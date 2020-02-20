import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto bs = new int[][](K*2, K*2);
    foreach (_; 0..N) {
        auto xyc = readln.split;
        auto x = xyc[0].to!int;
        auto y = xyc[1].to!int;
        if (xyc[2] == "B") {
            bs[y%(K*2)][x%(K*2)] += 1;
        } else {
            bs[y%(K*2)][(x+K)%(K*2)] += 1;
        }
    }
    foreach (i; 0..K*2) {
        foreach (j; 0..K*2) {
            if (i > 0) bs[i][j] += bs[i-1][j];
            if (j > 0) bs[i][j] += bs[i][j-1];
            if (i > 0 && j > 0) bs[i][j] -= bs[i-1][j-1];
        }
    }

    int r;
    auto m = K*2-1;
    foreach (i; 0..K) {
        foreach (j; 0..K) {
            r = max(r,
                bs[m][m] - bs[K+i][m] - bs[m][K+j] + bs[K+i][K+j]
                + bs[K+i][K+j] - bs[i][K+j] - bs[K+i][j] + bs[i][j]
                + bs[i][m] - bs[i][K+j]
                + bs[m][j] - bs[K+i][j]
                + bs[i][j]
            );
            r = max(r,
                bs[K+i][m] - bs[K+i][K+j] - bs[i][m] + bs[i][K+j]
                + bs[m][K+j] - bs[K+i][K+j] - bs[m][j] + bs[K+i][j]
                + bs[i][K+j] - bs[i][j]
                + bs[K+i][j] - bs[i][j]
            );
        }
    }
    writeln(r);
} 