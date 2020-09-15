import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    long[] BS;
    foreach (_; 0..N) BS ~= readln.chomp.to!long;
    auto AS = new long[](N);
    foreach (i; 0..N) {
        auto b1 = BS[(N+i-1)%N];
        auto b2 = BS[i];
        AS[i] = b1 / gcd(b1, b2) * b2;
    }
    auto CS = new long[](N);
    foreach (i; 0..N) {
        auto a1 = AS[i];
        auto a2 = AS[(i+1)%N];
        CS[i] = gcd(a1, a2);
    }

    int r = int.max;
    foreach (s; 0..min(6, N)) {
        int c, rr;
        foreach (ii; 0..N) {
            auto i = (ii+s)%N;
            if (c) {
                --c;
            } else if (BS[i] != CS[i]) {
                ++rr;
                c = 2;
            }
        }
        r = min(r, rr);
    }
    writeln(r);
}

/*

B1= gdc(A1, A2) B2= gcd(A2, A3)

A2は gcd(B1, B2) の倍数


4 2 4



3 3 4 4 5 45 18 2 5 15
 3 1 4 1 5  9  2 _ 5  3

           * * * *
8 14 7 8 8 2 3 5 2 8
 2  7 1 8 2 _ 1 _ 2 8


*/