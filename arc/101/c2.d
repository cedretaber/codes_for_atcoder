import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[10^^5] XS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (i, x; readln.split.to!(int[])) {
        XS[i] = x;
    }
    int l, r = K - 1, min_res = int.max;
    while (r < N) {
        auto ld = XS[l];
        auto rd = XS[r];
        int res;
        if ((ld < 0) == (rd < 0)) {
            ld = abs(ld);
            rd = abs(rd);
            res = max(ld, rd);
        } else {
            ld = abs(ld);
            rd = abs(rd);
            res = ld > rd ? rd * 2 + ld : ld * 2 + rd;
        }
        min_res = min(min_res, res);
        ++l;
        ++r;
    }
    writeln(min_res);
}
