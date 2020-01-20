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

long inv(long x)
{
    return pow(x, P-2);
}

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    long x = as[0];
    foreach (a; as[1..$]) {
        x = ((a * x) / gcd(a, x)) % P;
    }
    long r;
    foreach (a; as) {
        r = (r + x / a) % P;
    }
    writeln(r);
}