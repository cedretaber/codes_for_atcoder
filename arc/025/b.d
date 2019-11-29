import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[100][100] BS, WS;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    foreach (i; 0..H) {
        foreach (j, c; readln.split.to!(int[])) {
            if ((i+j)%2 == 0) {
                BS[i][j] = c;
            } else {
                WS[i][j] = c;
            }
        }
    }
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (i > 0) {
                BS[i][j] += BS[i-1][j];
                WS[i][j] += WS[i-1][j];
            }
            if (j > 0) {
                BS[i][j] += BS[i][j-1];
                WS[i][j] += WS[i][j-1];
            }
            if (i > 0 && j > 0) {
                BS[i][j] -= BS[i-1][j-1];
                WS[i][j] -= WS[i-1][j-1];
            }
        }
    }
    int r;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            foreach (k; 0..i+1) {
                foreach (l; 0..j+1) {
                    auto b = BS[i][j];
                    auto w = WS[i][j];
                    if (k > 0) {
                        b -= BS[k-1][j];
                        w -= WS[k-1][j];
                    }
                    if (l > 0) {
                        b -= BS[i][l-1];
                        w -= WS[i][l-1];
                    }
                    if (k > 0 && l > 0) {
                        b += BS[k-1][l-1];
                        w += WS[k-1][l-1];
                    }
                    if (b == w) {
                        r = max(r, (i-k+1)*(j-l+1));
                    }
                }
            }
        }
    }
    writeln(r);
}