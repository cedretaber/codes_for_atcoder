import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 1000000007L;

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
    auto A = readln.chomp.to!long;
    auto B = readln.chomp.to!long;
    auto C = readln.chomp.to!long;

    auto c = (B*C%P - A*B%P + P)%P * inv((A*C%P - B*C%P + A*B%P + P)%P) % P;
    auto r = (B*C%P - A*C%P + P)%P * inv((A*B%P - B*C%P + A*C%P + P)%P) % P;
    writeln(r, " ", c);
}