import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[101][101][101] CS, PS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..N) {
        auto c = readln.split.to!(long[]);
        CS[c[0]][c[1]][c[2]] = max(CS[c[0]][c[1]][c[2]], c[3]);
    }
    foreach (a; 0..101) {
        foreach (b; 0..101) {
            foreach (c; 0..101) {
                long x, y, z;
                if (a > 0) x = PS[a-1][b][c];
                if (b > 0) y = PS[a][b-1][c];
                if (c > 0) z = PS[a][b][c-1];
                PS[a][b][c] = max(x, y, z, CS[a][b][c]);
            }
        }
    }
    foreach (_; 0..M) {
        auto p = readln.split.to!(int[]);
        writeln(PS[p[0]][p[1]][p[2]]);
    }
}