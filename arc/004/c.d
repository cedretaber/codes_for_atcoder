import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range, std.traits, std.meta;

void main()
{
    auto xy = readln.chomp.split('/').to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto d = gcd(X, Y);
    X /= d;
    Y /= d;

    auto l = (2*X + Y - 1) / Y - 1;
    auto r = (2*X + Y) / Y;

    long[] ns, ms;
    foreach (n; l..r+1) {
        auto a = n * (X * -2 + n * Y + Y);
        auto b = 2 * Y;
        if (a && a % b == 0) {
            ns ~= n;
            ms ~= a/b;
        }
    }

    if (ns.empty) {
        writeln("Impossible");
    } else {
        foreach (i; 0..ns.length) {
            writeln(ns[i], " ", ms[i]);
        }
    }
}

/*

- (N * (N+1) / 2 - M) / N = X/Y
- N >= 1
- N >= M >= 1
を式変形すると、
- (解の公式から導かれたややこしい式) <= N <= (2X+Y)/Y
- M = N(-2X + YN + Y) / 2Y


N(-2X + NY + Y) / 2Y

Y(N+1) > 2X
N+1 > 2X/Y
N > 2X/Y - 1


2X/Y - 1 < N < (2X+Y)/Y

(2X+Y)/Y - (2X/Y - 1)
= 2X/Y + 1 - 2X/Y + 1
= 2

1/2
0 < N <= 2

2/3
1 < N <= 2

2(-2*2 + 2*3 + 3) / 2*3
= 2(-4 + 6 + 3) / 6
= 10 / 6

*/