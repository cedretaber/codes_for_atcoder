import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[2*10^^5] AS, SAS;

size_t bsearch(long[] arr, long targ)
{
    size_t min_p = 0, max_p = arr.length - 1;
    while (max_p - min_p > 1) {
        auto mid_p = (min_p + max_p) / 2;
        auto piv = arr[mid_p];
        if (piv > targ) {
            max_p = mid_p;
        } else {
            min_p = mid_p;
        }
    }
    return abs(targ - arr[min_p]) < abs(targ - arr[max_p]) ? min_p : max_p;
}

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, e; readln.split.to!(long[])) {
        AS[i] = e;
        if (i) {
            SAS[i] = SAS[i-1] + e;
        } else {
            SAS[i] = e;
        }
    }
    auto SUM = SAS[N-1];

    long P, Q, R, S, ret = long.max;
    foreach (pi; 0..N-3) {
        P = SAS[pi];
        auto qi = bsearch(SAS[pi+1..N-2], P+P) + pi + 1;
        Q = SAS[qi] - P;
        auto ri = bsearch(SAS[qi+1..N-1], P+Q+P) + qi + 1;
        R = SAS[ri] - Q - P;
        S = SUM - P - Q - R;
        auto max_s = max(P, Q, R, S), min_s = min(P, Q, R, S);
        ret = min(ret, max_s - min_s);
    }

    reverse(AS[0..N]);
    foreach (i, a; AS) {
        if (i) {
            SAS[i] = SAS[i-1] + a;
        } else {
            SAS[i] = a;
        }
    }
    foreach (pi; 0..N-3) {
        P = SAS[pi];
        auto qi = bsearch(SAS[pi+1..N-2], P+P) + pi + 1;
        Q = SAS[qi] - P;
        auto ri = bsearch(SAS[qi+1..N-1], P+Q+P) + qi + 1;
        R = SAS[ri] - Q - P;
        S = SUM - P - Q - R;
        auto max_s = max(P, Q, R, S), min_s = min(P, Q, R, S);
        ret = min(ret, max_s - min_s);
    }

    writeln(ret);
}