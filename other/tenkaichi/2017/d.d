import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

uint[10^^5] AS;
long[10^^5] BS;

void main()
{
    auto nk = readln.split;
    auto N = nk[0].to!int;
    auto K = nk[1].to!uint;

    foreach (i; 0..N) {
        auto ab = readln.split;
        AS[i] = ab[0].to!uint;
        BS[i] = ab[1].to!long;
    }

    long r_max;
    foreach (i; 0..32) {
        uint m;
        if (!(K&(1<<i))) {
            if (i == 31) {
                m = K;
            } else {
                continue;
            }
        } else {
            m = K&(~(1<<i)) | ((1<<i)-1);
        }
        long r;
        foreach (j; 0..N) {
            if ((AS[j]|m) == m) r += BS[j];
        }
        r_max = max(r_max, r);
    }

    writeln(r_max);
}