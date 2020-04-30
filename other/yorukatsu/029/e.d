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

Tuple!(N, N)[] prime_division(N)(N n)
{
    Tuple!(N, N)[] res;
    foreach (N i; 2..10^^3+1) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != cast(N)1) res ~= tuple(n, cast(N)1);
    return res;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    long[long] memo;
    long[long][] aps;
    foreach (a; AS) {
        auto ps = prime_division(a);
        foreach (p; ps) {
            if (p[0] in memo) {
                memo[p[0]] = max(memo[p[0]], p[1]);
            } else {
                memo[p[0]] = p[1];
            }
        }
    }
    long x = 1;
    foreach (n, k; memo) (x *= pow(n, k)) %= P;
    long r;
    foreach (a; AS) (r += x * inv(a) % P) %= P;
    writeln(r);
}