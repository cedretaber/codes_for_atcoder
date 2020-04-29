import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10L^^9+7;

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
    auto cs = readln.split.to!(long[]);
    sort!"a > b"(cs);
    auto inv_2 = inv(2);
    auto xx = 2.pow(N*2) * inv_2 % P;
    long x = xx, r;
    (xx *= inv_2) %= P;
    foreach (c; cs) {
        (r += x * c % P) %= P;
        (x += xx) %= P;
    }
    writeln(r);
}