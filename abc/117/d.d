import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

ulong[10^^5] AS;
int[40] BS;
bool[40] KS;

void main()
{
    auto nk = readln.split.to!(ulong[]);
    auto N = nk[0];
    auto K = nk[1];
    ulong o = 1;

    foreach (i, a; readln.split.to!(ulong[])) {
        AS[i] = a;
        foreach (j; 0..40) {
            BS[j] += ((o<<j) & a) ? 1 : 0;
        }
    }

    foreach (i; 0..40) {
        KS[i] = !!((o<<i) & K);
    }

    ulong ret;
    foreach (i; 0..40) {
        if (!KS[i]) continue;
        ulong x;
        foreach (j; 0..i) {
            if (BS[j] <= N / 2) {
                x |= (o<<j);
            }
        }
        foreach (j; i+1..40) {
            x |= ((o<<j) & K);
        }
        ulong r;
        foreach (a; AS[0..N]) {
            r += a ^ x;
        }
        ret = max(ret, r);
    }

    ulong r;
    foreach (a; AS[0..N]) {
        r += a ^ K;
    }
    ret = max(ret, r);

    writeln(ret);
}