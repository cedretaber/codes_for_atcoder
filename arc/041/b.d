import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    int[][] b2;
    b2.length = N;
    foreach (i; 0..N) b2[i] = readln.chomp.map!(i => i - '0').array.to!(int[]);

    auto b1 = new int[][](N, M);

    foreach (i; 1..N-1) {
        foreach (j; 1..M-1) {
            auto n = b2[i-1][j];
            b1[i][j] = n;
            b2[i-1][j] -= n;
            b2[i+1][j] -= n;
            b2[i][j-1] -= n;
            b2[i][j+1] -= n;
        }
    }

    foreach (l; b1) writeln(l.to!(string[]).join(""));
}