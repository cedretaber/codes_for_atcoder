import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(long[]);
    auto N = nd[0];
    auto D = nd[1];

    int a, b, c;
    while (D%2 == 0) {
        a += 1;
        D /= 2;
    }
    while (D%3 == 0) {
        b += 1;
        D /= 3;
    }
    while (D%5 == 0) {
        c += 1;
        D /= 5;
    }

    if (D != 1) {
        writeln(0);
        return;
    }

    auto DP = new double[][][][](2, a+1, b+1, c+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) foreach (ref dp3; dp2) dp3[] = 0;
    DP[0][0][0][0] += 1.0/6.0;
    DP[0][min(a, 1)][0][0] += 1.0/6.0;
    DP[0][0][min(b, 1)][0] += 1.0/6.0;
    DP[0][min(a, 2)][0][0] += 1.0/6.0;
    DP[0][0][0][min(c, 1)] += 1.0/6.0;
    DP[0][min(a, 1)][min(b, 1)][0] += 1.0/6.0;
    foreach (i; 0..N-1) {
        foreach (x; 0..a+1) {
            foreach (y; 0..b+1) {
                foreach (z; 0..c+1) {
                    DP[(i+1)%2][x][y][z] = 0;
                }
            }
        }
        foreach (x; 0..a+1) {
            foreach (y; 0..b+1) {
                foreach (z; 0..c+1) {
                    auto p = DP[i%2][x][y][z];
                    DP[(i+1)%2][x][y][z] += p / 6.0;
                    DP[(i+1)%2][min(a, x+1)][y][z] += p / 6.0;
                    DP[(i+1)%2][x][min(b, y+1)][z] += p / 6.0;
                    DP[(i+1)%2][min(a, x+2)][y][z] += p / 6.0;
                    DP[(i+1)%2][x][y][min(c, z+1)] += p / 6.0;
                    DP[(i+1)%2][min(a, x+1)][min(b, y+1)][z] += p / 6.0;
                }
            }
        }
    }
    writefln("%.12f", DP[(N+1)%2][a][b][c]);
}