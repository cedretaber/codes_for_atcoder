import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nc = readln.split.to!(int[]);
    auto N = nc[0];
    auto C = nc[1];

    long[][] DS;
    DS.length = C;
    foreach (i; 0..C) DS[i] = readln.split.to!(long[]);

    auto CS = new long[][](3, C);
    foreach (i; 0..N) foreach (j, c; readln.split.to!(int[])) ++CS[(i+j)%3][c-1];

    auto r = long.max;
    foreach (i; 0..C) {
        foreach (j; 0..C) {
            foreach (k; 0..C) {
                if (i == j || j == k || k == i) continue;
                long rr;
                foreach (c; 0..C)
                    rr +=
                        DS[c][i] * CS[0][c] +
                        DS[c][j] * CS[1][c] +
                        DS[c][k] * CS[2][c];
                r = min(r, rr);
            }
        }
    }
    writeln(r);
}