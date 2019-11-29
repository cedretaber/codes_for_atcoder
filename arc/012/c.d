import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[4][19][19] F;

void main()
{
    char[][] B;
    B.length = 19;
    int b, w;
    foreach (i; 0..19) {
        B[i] = readln.chomp.to!(char[]);
        foreach (c; B[i]) {
            if (c == 'o') {
                ++b;
            } else if (c == 'x') {
                ++w;
            }
        }
    }
    
    if (b == 0 && w == 0) {
        writeln("YES");
        return;
    }

    char x;
    if (b == w+1) {
        x = 'o';
    } else if (b == w) {
        x = 'x';
    } else {
        writeln("NO");
        return;
    }

    int s(int i, int j, int di, int dj, int d, char c) {
        if (i < 0 || 19 <= i || j < 0 || 19 <= j || B[i][j] != c) {
            return 0;
        }
        F[i][j][d] = true;
        auto ii = i + di;
        auto jj = j + dj;
        return 1 + s(ii, jj, di, dj, d, c);
    }
    int max_c;
    void inner(int t) {
        foreach (i; 0..19) {
            foreach (j; 0..19) {
                if (B[i][j] != '.') {
                    auto c = B[i][j];
                    if (F[i][j][0] != t) {
                        F[i][j][0] = t;
                        max_c = max(max_c, 1 + s(i+1, j, 1, 0, 0, c) + s(i-1, j, -1, 0, 0, c));
                    }
                    if (F[i][j][1] != t) {
                        F[i][j][1] = t;
                        max_c = max(max_c, 1 + s(i, j+1, 0, 1, 1, c) + s(i, j-1, 0, -1, 1, c));
                    }
                    if (F[i][j][2] != t) {
                        F[i][j][2] = t;
                        max_c = max(max_c, 1 + s(i+1, j+1, 1, 1, 2, c) + s(i-1, j-1, -1, -1, 2, c));
                    }
                    if (F[i][j][3] != t) {
                        F[i][j][3] = t;
                        max_c = max(max_c, 1 + s(i+1, j-1, 1, -1, 3, c) + s(i-1, j+1, -1, 1, 3, c));
                    }
                }
            }
        }
    }

    int t;
    foreach (i; 0..19) {
        foreach (j; 0..19) {
            if (B[i][j] == x) {
                B[i][j] = '.';
                max_c = 0;
                inner(++t);
                if (max_c < 5) goto yes; 
                B[i][j] = x;
            }
        }
    }
    writeln("NO");
    return;
    yes:
    writeln("YES");
}