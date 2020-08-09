import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nqst = readln.split.to!(int[]);
    auto N = nqst[0];
    auto Q = nqst[1];
    long S = nqst[2];
    long T = nqst[3];
    long[] AS, DS;
    foreach (_; 0..N+1) AS ~= readln.chomp.to!long;
    foreach (i; 0..N) DS ~= AS[i+1] - AS[i];
    long t;
    foreach (d; DS) t -= d > 0 ? d * S : d * T;
    foreach (_; 0..Q) {
        auto lrx = readln.split.to!(int[]);
        auto L = lrx[0]-1;
        auto R = lrx[1];
        long X = lrx[2];
        t += DS[L] > 0 ? DS[L] * S : DS[L] * T;
        if (R < N) t += DS[R] > 0 ? DS[R] * S : DS[R] * T;
        DS[L] += X;
        if (R < N) DS[R] -= X;
        t -= DS[L] > 0 ? DS[L] * S : DS[L] * T;
        if (R < N) t -= DS[R] > 0 ? DS[R] * S : DS[R] * T;
        writeln(t);
    }
}

/*

0 4 1 8
4 -3 7


0 6 3 8
6 -3 5

0 4 3 8
4 -1 5

*/