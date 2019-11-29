import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long solve(char[] n)
{
    long[10][2][2][20] DP;
    foreach (i; 0..n.length) {
        auto x = n[i].to!int - 48;
        if (i == 0) {
            foreach (j; 0..x+1) {
                if (j == 4 || j == 9) {
                    DP[i][1][x == j ? 1 : 0][j] = 1;
                } else {
                    DP[i][0][x == j ? 1 : 0][j] = 1;
                }
            }
        } else {
            auto y = n[i-1].to!int - 48;
            foreach (j; 0..x+1) {
                if (j == 4 || j == 9) {
                    DP[i][1][x == j ? 1 : 0][j] += DP[i-1][0][1][y] + DP[i-1][1][1][y];
                } else {
                    DP[i][0][x == j ? 1 : 0][j] += DP[i-1][0][1][y];
                    DP[i][1][x == j ? 1 : 0][j] += DP[i-1][1][1][y];
                }
            }
            foreach (j; 0..10) {
                foreach (k; 0..10) {
                    if (j == 4 || j == 9) {
                        DP[i][1][0][j] += DP[i-1][0][0][k] + DP[i-1][1][0][k];
                    } else {
                        DP[i][1][0][j] += DP[i-1][1][0][k];
                        DP[i][0][0][j] += DP[i-1][0][0][k];
                    }
                }
            }
        }
    }
    long r;
    foreach (i; 0..10) {
        r += DP[n.length-1][1][0][i] + DP[n.length-1][1][1][i];
    }
    return r;
}

void main()
{
    auto ab = readln.split.to!(char[][]);
    writeln(solve(ab[1]) - solve((ab[0].to!long-1).to!(char[])));
}