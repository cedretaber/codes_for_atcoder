import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

Tuple!(N, N)[] prime_division(N)(N n)
{
    Tuple!(N, N)[] res;
    foreach (N i; 2..10^^4+1) {
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
    auto ps = prime_division(N);
    int r = 1;
    foreach (p; ps) r = max(r, p[0] * p[1]);
    writeln(r);
}