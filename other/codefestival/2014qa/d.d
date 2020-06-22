import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto ak = readln.split;
    auto A = ak[0];
    auto N = A.to!long;
    auto K = ak[1].to!int;

    long r = N - 10L^^(A.length-1) + 1;
    foreach (p; 1..2^^10) {
        if (popcnt(p) != K) continue;
        long a, b;
        foreach (c; A) {
            auto n = (c - '0').to!long;
            if (a == 0) {
                long x = 10, y = 10;
                foreach (i; 0..10) if (p & (1<<i)) {
                    if (n >= i) x = min(x, n-i);
                    if (n <= i) y = min(y, i-n);
                }
                if (x != 0) {
                    a = x;
                    b = y;
                }
            } else {
                foreach_reverse (i; 0..10) if (p & (1<<i)) {
                    (a *= 10) += n - i;
                    break;
                }
                foreach (i; 0..10) if (p & (1<<i)) {
                    (b *= 10) += i - n;
                    break;
                }
            }
        }
        r = min(r, a, b);
    }
    writeln(r);
}