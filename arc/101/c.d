import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[10^^5] PXS, MXS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    int i, j;
    foreach (x; readln.split.to!(int[])) {
        if (x > 0) {
            PXS[i++] = x;
        } else if (x < 0) {
            MXS[j++] = -x;
        } else {
            --K;
        }
    }
    reverse(MXS[0..j]);

    int l, r;
    if (j > K) {
        l = K - 1;
        r = -1;
    } else {
        l = j - 1;
        r = K - j - 1;
    }

    auto min_ret = int.max;
    while (r < K && r < i && l >= -1) {
        auto ld = l == -1 ? 0 : MXS[l];
        auto rd = r == -1 ? 0 : PXS[r];
        auto ret = ld > rd ? ld + rd * 2 : rd + ld * 2;
        min_ret = min(min_ret, ret);
        --l;
        ++r;
    }
    writeln(min_ret);
}