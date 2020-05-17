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

alias Iw = Tuple!(long, "a", long, "b");
alias Pair = Tuple!(long, "x", long, "y");

void main()
{
    auto N = readln.chomp.to!int;
    long[Iw] iws;
    long zz;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto A = ab[0];
        auto B = ab[1];
        if (A < 0) {
            A = -A;
            B = -B;
        }
        if (A == 0 && B == 0) {
            ++zz;
            continue;
        } else if (A == 0) {
            B = 1;
        } else if (B == 0) {
            A = 1;
        } else if (A != 0 && B != 0) {
            auto d = gcd(abs(A), abs(B));
            A /= d;
            B /= d;
        }
        auto iw = Iw(A, B);
        if (iw !in iws) iws[iw] = 0;
        ++iws[iw];
    }

    Pair[] ps;
    foreach (k, n; iws) {
        if (n == 0) continue;
        auto r = k.b < 0 ? Iw(-k.b, k.a) : Iw(k.b, -k.a);
        if (r.a == 0) r.b = abs(r.b);
        if (r in iws && iws[r] > 0) {
            ps ~= Pair(n, iws[r]);
            iws[r] = 0;
        } else {
            ps ~= Pair(n, 0);
        }
    }

    long r = 1;
    foreach (p; ps) {
        if (p.y == 0) {
            (r *= pow(2, p.x)) %= P;
        } else {
            long z = (pow(2, p.x) + pow(2, p.y)) % P;
            z = (z - 1 + P) % P;
            (r *= z) %= P;
        }
    }
    writeln((r - 1 + zz + P) % P);
}