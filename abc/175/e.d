import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto rck = readln.split.to!(int[]);
    auto R = rck[0];
    auto C = rck[1];
    auto K = rck[2];
    auto MAP = new long[][](R, C);
    foreach (_; 0..K) {
        auto rcv = readln.split.to!(int[]);
        auto r = rcv[0]-1;
        auto c = rcv[1]-1;
        long v = rcv[2];
        MAP[r][c] = v;
    }

    auto DP = new long[][][](R+1, C+1, 4);
    foreach (r; 0..R) {
        foreach (c; 0..C) {
            foreach (k; 0..4) {
                if (k < 3) {
                    DP[r][c+1][k+1] = max(DP[r][c+1][k+1], DP[r][c][k] + MAP[r][c]);
                    DP[r+1][c][0] = max(DP[r+1][c][0], DP[r][c][k] + MAP[r][c]);
                }
                DP[r][c+1][k] = max(DP[r][c+1][k],  DP[r][c][k]);
                DP[r+1][c][0] = max(DP[r+1][c][0], DP[r][c][k]);
            }
        }
    }
    long r;
    foreach (k; 0..4) r = max(r, DP[R][C-1][k]);
    writeln(r);
}