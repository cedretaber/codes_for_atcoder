import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

Tuple!(N, N)[] prime_division(N)(N n)
{
    Tuple!(N, N)[] res;
    foreach (N i; 2..10^^6+1) {
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
    auto N = readln.chomp.to!long;
    auto ps = prime_division(N);
    int r;
    foreach (p; ps) {
        auto k = p[1];
        foreach (i; 1..40) {
            if (k < i) break;
            ++r;
            k -= i;
        }
    }
    writeln(r);
}