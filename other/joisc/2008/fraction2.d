import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto mk = readln.split.to!(int[]);
    auto M = mk[0];
    auto K = mk[1];

    int m, n;
    void solve(int lm, int ln, int rm, int rn) {
        auto mm = lm + rm;
        auto mn = ln + rn;
        if (mn > M) return;
        if (K < 0) return;
        solve(lm, ln, mm, mn);
        if (--K == 0) {
            m = mm;
            n = mn;
            return;
        }
        solve(mm, mn, rm, rn);
    }
    solve(0, 1, 1, 1);
    if (m == 0) {
        writeln(-1);
    } else {
        writeln(m, " ", n);
    }
}