import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[10][10] M;

void main()
{
    foreach (i; 0..10) {
        foreach (j, c; readln.chomp.to!(char[])) {
            if (c == 'o') {
                M[i][j] = 1;
            } else {
                M[i][j] = 0;
            }
        }
    }

    void put(int ii, int jj, int n) {
        foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {
            auto i = ii+d[0];
            auto j = jj+d[1];
            if (i < 0 || i > 9 || j < 0 || j > 9) continue;
            if (M[i][j] == 0 || M[i][j] == n) continue;
            M[i][j] = n;
            put(i, j, n);
        }
    }
    foreach (i; 0..10) {
        foreach (j; 0..10) {
            auto n = i*10+j+2;
            if (M[i][j] != 0) M[i][j] = n;
            put(i, j, n);
            foreach (a; 0..10) {
                foreach (b; 0..10) {
                    if (M[a][b] == 0 || M[a][b] == n) continue;
                    goto ng;
                }
            }
            writeln("YES");
            return;
            ng:
        }
    }
    writeln("NO");
}