import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias LR = Tuple!(long, "l", long, "r");

void main()
{
    auto nxd = readln.split.to!(long[]);
    auto N = nxd[0];
    auto X = nxd[1];
    auto D = nxd[2];

    if (D == 0) {
        writeln(X == 0 ? 1 : N+1);
        return;
    }

    if (D < 0) {
        X = -X;
        D = -D;
    }

    auto kcm = new long[](N);
    foreach (i; 0..N) {
        if (i != 0) {
            kcm[i] = kcm[i-1] + i;
        }
    }

    LR[][long] CM;
    foreach (k; 0..N+1) {
        CM[(k*X)%D] ~= LR(kcm[max(0, k-1)] + k*X/D, kcm[N-1] - kcm[max(0, N-k-1)] + k*X/D);
    }
    long ret;
    foreach (_, lrs; CM) {
        sort!"a.l < b.l"(lrs);
        long l = long.max, r;
        foreach (lr; lrs) {
            if (l == long.max) {
                l = lr.l;
                r = lr.r;
            } else if (lr.l <= r) {
                r = max(r, lr.r);
            } else {
                ret += r - l + 1;
                l = lr.l;
                r = lr.r;
            }
        }
        if (l != long.max) {
            ret += r - l + 1;
        }
    }
    writeln(ret);
}