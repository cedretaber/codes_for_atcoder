import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range, std.math;

enum ulong N = 10^^9+7;

ulong[2][(10^^5)*2] FS;
ulong[10^^5] PS;

void main()
{
    foreach (i, e; FS) {
        if (i == 0) {
            e[0] = 0;
        } else if (i == 1) {
            e[0] = 1;
        } else {
            e[0] = FS[i-1][0] * i % N;
        }
        e[1] = powmod(e[0], N-2, N);
    }

    auto hwab = readln.split.to!(ulong[]);
    auto H = hwab[0];
    auto W = hwab[1];
    auto A = hwab[2];
    auto B = hwab[3];

    foreach (i; 0..H-A) {
        PS[i] = FS[B+i][0] * FS[B][1] * FS[i][1] % N;
    }

    long ret;
    foreach (i, e; PS) if (e > 0) {
        ret = (ret + e * (FS[H-i+W-B][0] * FS[H-i][1] * FS[W-B][1] % N)) % N;
    }

    writeln(ret);
}