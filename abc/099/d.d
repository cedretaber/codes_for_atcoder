import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[30][30] DC;
int[30][3] CS;

void main()
{
    auto nc = readln.split.to!(int[]);
    auto N = nc[0];
    auto C = nc[1];

    foreach (i; 0..C) {
        foreach (j, d; readln.split) {
            DC[i][j] = d.to!int;
        }
    }

    foreach (i; 0..N) {
        foreach (j, c; readln.split) {
            CS[(i+j+2)%3][c.to!int-1]++;
        }
    }

    auto ret = long.max;
    foreach (a; 0..C) {
        foreach (b; 0..C) {
            if (b == a) continue;
            foreach (c; 0..C) {
                if (a == c || b == c) continue;
                long sum;
                foreach (x, aa; CS[0][0..C]) sum += DC[x][a] * aa;
                foreach (x, bb; CS[1][0..C]) sum += DC[x][b] * bb;
                foreach (x, cc; CS[2][0..C]) sum += DC[x][c] * cc;
                ret = min(ret, sum);
            }
        }
    }

    writeln(ret);
}