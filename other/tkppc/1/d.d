import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nrc = readln.split.to!(int[]);
    auto N = nrc[0];
    auto R = nrc[1];
    auto C = nrc[2];
    auto MAP = new int[][][](N, R, C);
    foreach (k; 0..N) {
        foreach (i; 0..R) {
            foreach (j, c; readln.chomp) {
                if (c == 'H') {
                    MAP[k][i][j] = 0;
                } else {
                    MAP[k][i][j] = c - '0';
                }
            }
        }
    }
    auto DP = new int[][][](N, R, C);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    int solve(int k, int i, int j) {
        if (k == N-1 && i == R-1 && j == C-1) return 0;
        if (DP[k][i][j] == -1) {
            if ((k != 0 || i != 0 || j != 0) && MAP[k][i][j] == 0) {
                DP[k][i][j] = solve(k+1, i, j);
            } else {
                int r = int.max/3;
                if (i+1 < R) r = min(r, solve(k, i+1, j));
                if (j+1 < C) r = min(r, solve(k, i, j+1));
                DP[k][i][j] = r + MAP[k][i][j];
            }
        }
        return DP[k][i][j];
    }
    writeln(solve(0, 0, 0));
}