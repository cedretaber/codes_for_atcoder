import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[10^^5] XS;
long[10^^5] VS;

void main()
{
    auto nc = readln.split.to!(long[]);
    auto N = nc[0];
    auto C = nc[1];

    foreach (i; 0..N) {
        auto xv = readln.split.to!(long[]);
        XS[i] = xv[0];
        VS[i] = xv[1];
    }

    long[10^^5] tb;
    tb[0] = VS[0] - XS[0];
    long max_v = tb[0], max_p = long.min, max_i;
    foreach (i; 1..N) {
        tb[i] = tb[i-1] + VS[i] + XS[i-1] - XS[i];
        if (tb[i] > max_v) max_v = tb[i];
        if (tb[i] - XS[i] > max_p) {
            max_p = tb[i] - XS[i];
            max_i = i;
        }
    }
    if (max_i != N-1) {
        tb[N-1] = max_p - (C - XS[N-1]) + VS[N-1];
        foreach_reverse (i; 0..N-1) {
            if (i == max_i) break;
            tb[i] = tb[i+1] + VS[i] - XS[i+1] + XS[i];
            if (tb[i] > max_v) max_v = tb[i];
        }
    }
    auto r1 = max_v;

    tb[N-1] = VS[N-1] - (C - XS[N-1]);
    max_v = tb[N-1];
    max_p = long.min;
    long min_i = long.max;
    foreach_reverse (i; 0..N-1) {
        tb[i] = tb[i+1] + VS[i] + XS[i] - XS[i+1];
        if (tb[i] > max_v) max_v = tb[i];
        if (tb[i] - (C - XS[i]) > max_p) {
            max_p = tb[i];
            min_i = i;
        }
    }
    if (min_i != 0) {
        tb[0] = max_p - XS[0] + VS[0];
        foreach (i; 1..N) {
            if (i == min_i) break;
            tb[i] = tb[i-1] + VS[i] + XS[i-1] - XS[i];
            if (tb[i] > max_v) max_v = tb[i];
        }
    }
    auto r2 = max_v;

    writeln(max(r1, r2, 0));
}