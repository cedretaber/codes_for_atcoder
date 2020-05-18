import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void prime_division(N)(N n, ref long[long] res)
{
    foreach (N i; 2..10^^5+1) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            if (i !in res) res[i] = 0;
            res[i] += cnt;
        }
    }
    if (n != cast(N)1) {
        if (n !in res) res[n] = 0;
        res[n] += 1;
    }
}

void main()
{
    auto ab = readln.split.to!(long[]);
    auto A = ab[0];
    auto B = ab[1];

    long[long] nn;
    foreach (n; B+1..A+1) prime_division(n, nn);
    long r = 1;
    foreach (n; nn) (r *= (n+1)) %= P;
    writeln(r);
}