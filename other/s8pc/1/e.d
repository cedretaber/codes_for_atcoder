import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

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
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto as = readln.split.to!(long[]);
    auto qs = [1L] ~ readln.split.to!(long[]) ~ [1L];

    auto cs = new long[](N);
    foreach (i; 1..N) {
        cs[i] = (cs[i-1] + pow(as[i-1], as[i])) % P;
    }

    long r;
    foreach (i; 1..Q+2) {
        auto x = qs[i-1]-1;
        auto y = qs[i]-1;
        r = (r + cs[max(x, y)] - cs[min(x, y)] + P) % P;
    }

    writeln(r);
}