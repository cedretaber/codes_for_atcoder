import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    auto M = new int[][](H, W);
    foreach (i; 0..H) foreach (j, a; readln.split.to!(int[])) M[i][j] = a;
    foreach (i; 0..H) foreach (j, b; readln.split.to!(int[])) M[i][j] = abs(M[i][j] - b);

    auto max_d = 80*(H+W);
    auto DP = new int[][][](H, W, max_d+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    int solve(int i, int j, int d) {
        if (i == H-1 && j == W-1) return abs(d - M[i][j]);
        if (DP[i][j][d] == -1) {
            auto d1 = d + M[i][j];
            auto d2 = abs(d - M[i][j]);
            if (d1 > max_d) d1 = d2;
            int r = max_d;
            if (i < H-1) {
                r = min(r, solve(i+1, j, d1));
                r = min(r, solve(i+1, j, d2));
            }
            if (j < W-1) {
                r = min(r, solve(i, j+1, d1));
                r = min(r, solve(i, j+1, d2));
            }
            DP[i][j][d] = r;
        }
        return DP[i][j][d];
    }
    writeln(solve(0, 0, 0));
}