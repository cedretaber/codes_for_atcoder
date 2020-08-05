import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;
long[2001] F, RF;

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

void main()
{
    init();
    auto N = readln.chomp.to!int;
    long r = 1, last = -1, k;
    foreach (a; readln.split.to!(long[])) {
        if (a == -1) {
            ++k;
        } else {
            if (last == -1) {
                last = a;
                continue;
            }

            if (k == 0) {
                last = a;
                continue;
            }

            auto n = a - last + k;
            long x = 1;
            foreach (d; 0..k) (x *= (n-d)) %= P;
            (r *= x * RF[k] % P) %= P;

            last = a;
            k = 0;
        }
    }
    writeln(r);
}