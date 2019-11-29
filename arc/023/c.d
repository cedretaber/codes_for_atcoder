import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum P = 10L^^9+7;
long[10^^5+50] F, RF;

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
    auto AS = readln.split.to!(int[]);

    size_t[2][] CS;
    {
        size_t i;
        int last;
        foreach (j, a; AS) {
            if (last == -1 && a != -1) {
                CS ~= [i, j-1];
            } else if (last != -1 && a == -1) {
                i = j;
            }
            last = a;
        }
    }
    long r = 1;
    foreach (c; CS) {
        auto i = c[0];
        auto j = c[1];
        auto s = AS[i-1];
        auto e = AS[j+1];

        auto d = e - s + 1;
        auto f = j - i + 1;

        long t = 1;
        foreach (long x; 0..f) {
            t = (t * (d + x)) % P;
        }
        t = (t * RF[f]) % P;
        r = (r * t) % P;
    }
    writeln(r);
}