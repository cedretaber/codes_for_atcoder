import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];

    auto cs = new int[][](N, N);
    foreach (_; 0..M) {
        auto lr = readln.split.to!(int[]);
        auto L = lr[0]-1;
        auto R = lr[1]-1;
        cs[L][R] += 1;
    }
    foreach (k; 1..N) {
        foreach (i; 0..N) {
            auto j = i+k;
            if (j >= N) break;
            cs[i][j] += cs[i+1][j] + cs[i][j-1];
            if (i+1 < j) cs[i][j] -= cs[i+1][j-1];
        }
    }
    foreach (_; 0..Q) {
        auto pq = readln.split.to!(int[]);
        writeln(cs[pq[0]-1][pq[1]-1]);
    }
}