import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto xs = new long[int][](M);
    foreach (x; readln.split.to!(int[])) {
        auto p = x % M;
        ++xs[p][x];
    }

    auto ps = new long[](M);
    auto rs = new long[](M);
    foreach (i, xx; xs) {
        foreach (_, v; xx) {
            ps[i] += v/2*2;
            rs[i] += v%2;
        }
    }

    long res = ps[0]/2 + rs[0]/2;
    foreach (i; 1..M) {
        auto j = M-i;
        if (i >= j) {
            if (i == j) res += ps[i]/2 + rs[i]/2;
            break;
        }
        auto r = min(rs[i], rs[j]);
        res += r;
        rs[i] -= r;
        rs[j] -= r;
        if (rs[i] > 0) {
            auto p = min(rs[i], ps[j]);
            res += p;
            ps[j] -= p;
        } else if (rs[j] > 0) {
            auto p = min(ps[i], rs[j]);
            res += p;
            ps[i] -= p;
        }
        res += ps[i]/2 + ps[j]/2;
    }
    writeln(res);
}