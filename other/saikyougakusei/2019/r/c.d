import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;
long[10^^5+50] F, RF;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

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
    auto S = readln.chomp.to!(char[]);

    int[] PS;
    PS.length = N*2;
    int x;
    foreach (i, c; S) {
        if (c == 'B') {
            if (x%2 == 0) {
                PS[i] = 1;
                ++x;
            } else {
                PS[i] = -1;
                --x;
            }
        } else {
            if (x%2 == 0) {
                PS[i] = -1;
                --x;
            } else {
                PS[i] = 1;
                ++x;
            }
        }
    }

    if (x != 0 || PS[0] == -1 || PS[$-1] == 1) {
        writeln(0);
        return;
    }

    int mc;
    long r = 1;
    foreach_reverse (p; PS) {
        if (p == -1) {
            ++mc;
        } else {
            r = (r * mc--) % P;
        }
    }

    writeln((r * F[N]) % P);
}