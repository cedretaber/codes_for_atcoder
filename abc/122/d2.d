import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    auto DP = new long[][][][](4, 4, 4, N);
    DP[0][0][0][0] = 1;
    DP[0][0][1][0] = 1;
    DP[0][0][2][0] = 1;
    DP[0][0][3][0] = 1;
    foreach (i; 1..N) {
        foreach (a; 0..4) foreach (b; 0..4) foreach (c; 0..4) foreach (x; 0..4) {
            if (i >= 2 && x == 1 && c == 2 && b == 0) continue;
            if (i >= 2 && x == 1 && c == 0 && b == 2) continue;
            if (i >= 2 && x == 2 && c == 1 && b == 0) continue;
            if (i >= 3 && x == 1 && c == 2 && a == 0) continue;
            if (i >= 3 && x == 1 && b == 2 && a == 0) continue;
            (DP[b][c][x][i] += DP[a][b][c][i-1]) %= P;
        }
    }
    long r;
    foreach (a; 0..4) foreach (b; 0..4) foreach (c; 0..4) {
        (r += DP[a][b][c][N-1]) %= P;
    }
    writeln(r);
}