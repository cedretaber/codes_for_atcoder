import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum P = 998244353L;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto DS = readln.split.to!(int[]);
    if (DS[0] != 0) {
        writeln(0);
        return;
    }

    auto ds = new long[](N);
    foreach (d; DS) ++ds[d];
    if (ds[0] != 1) {
        writeln(0);
        return;
    }
    long r = 1;
    int c;
    foreach (i, d; ds) {
        if (i != 0) {
            r = (r * pow(ds[i-1], d)) % P;
        }
        c += d;
        if (c == N) break;
    }
    writeln(r);
}