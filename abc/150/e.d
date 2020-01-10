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
    auto CS = readln.split.to!(long[]);
    sort!"a > b"(CS);
    long r, d = pow(2, N*2-1);
    foreach (i; 0..N) r = (r + (CS[i] * (d + ((d * 500000004) % P * i) % P) % P) % P) % P;
    writeln(r);
}