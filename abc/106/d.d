import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[500][500] MS, CS;

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];

    foreach (_; 0..M) {
        auto lr = readln.split.to!(int[]);
        ++MS[lr[0]-1][lr[1]-1];
    }

    foreach_reverse (s; 0..N) {
        foreach (e; s..N) {
            CS[s][e] = MS[s][e] +
                (e ? CS[s][e-1] : 0) +
                (s+1 < N ? CS[s+1][e] : 0) -
                (e && s+1 < N && s+1 <= e-1 ? CS[s+1][e-1] : 0);
        }
    }

    foreach (_; 0..Q) {
        auto pq = readln.split.to!(int[]);
        writeln(CS[pq[0]-1][pq[1]-1]);
    }
}