import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto Q = readln.split.to!(long[]);
    auto N = readln.chomp.to!long * 100;
    long[] A = [25, 50, 100, 200];

    long r = long.max;
    auto ss = [0,1,2,3];
    do {
        auto a = ss[0];
        auto b = ss[1];
        auto c = ss[2];
        auto d = ss[3];

        auto n = N;

        long rr;
        rr += n/A[a]*Q[a];
        n %= A[a];
        rr += n/A[b]*Q[b];
        n %= A[b];
        rr += n/A[c]*Q[c];
        n %= A[c];
        rr += n/A[d]*Q[d];

        r = min(r, rr);
    } while (nextPermutation(ss));

    writeln(r);
}