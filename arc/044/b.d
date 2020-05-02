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
    auto N = readln.chomp.to!int;
    auto vs = new long[](N);
    long max_a;
    foreach (i, a; readln.split.to!(long[])) {
        if ((i == 0 && a != 0) || (i != 0 && a == 0)) {
            writeln(0);
            return;
        }
        max_a = max(max_a, a);
        ++vs[a];
    }

    long r = 1;
    foreach (i; 1..max_a+1) {
        auto c = pow((pow(2, vs[i-1])-1+P)%P, vs[i]);
        auto d = pow(2, vs[i] * (vs[i]-1) / 2);
        (r *= c * d % P) %= P;
    }
    writeln(r);
}