import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(long[]);
    auto A = ab[0];
    auto B = ab[1];
    if (B < A) swap(A, B);

    long s = 1, r = 1;
    long[] rest;
    void solve(long x) {
        if (A%x != 0) return;
        if (B%x != 0) return;
        if (gcd(x, s) != 1) return;
        ++r;
        s *= x;
        return;
    }
    for (long x = 2; x^^2 <= A; ++x) {
        solve(x);
        if (A%x == 0) rest ~= A/x;
    }
    reverse(rest);
    foreach (x; rest) solve(x);
    if (A != 1) solve(A);
    writeln(r);
}