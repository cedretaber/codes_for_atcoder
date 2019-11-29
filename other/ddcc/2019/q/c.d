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
    auto N = readln.chomp.to!long;
    long r;
    foreach (i; 1..N+1) {
        auto x = (pow(i, 10) * pow(N/i, 10)) % P;
        auto y = (pow(i-1, 10) * pow(N/i, 10)) % P;
        auto z = (x - y + P) % P;
        r = (r + z) % P;
    }
    writeln(r);
}