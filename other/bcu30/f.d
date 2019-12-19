import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10L^^9+7;

long pow(long x, long n)
{
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long to_inv(long x)
{
    long n = 1;
    long k = P-2;
    while (k) {
        if (k%2 == 1) n = (n * x) % P;
        x = x^^2 % P;
        k /= 2;
    }
    return n;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    if (N == 1) {
        writeln(as[0]);
        return;
    } else if (N == 2) {
        writeln((as[0] + as[1] + as[0] * as[1]) % P);
        return;
    }
    long i2 = 2.to_inv();
    long a = (as[0] * pow(2, N-2)) % P;
    long ap = a;
    foreach (i; 1..N-1) {
        ap = ((ap * as[i]) % P * i2) % P;
        a = (a + ap) % P;
    }
    a = (a + ap * as[N-1]) % P;
    long s = a;
    foreach (i; 1..N-1) {
        a = (a * as[i-1].to_inv()) % P;
        if (i == 1) {
            a = (a + P - pow(2, N-2));
        } else {
            a = (a + P - pow(2, N-3));
            a = (a * 2) % P;
        }
        s = (s + a) % P;
    }
    writeln((s + as[N-1] * pow(2, N-2)) % P);
}