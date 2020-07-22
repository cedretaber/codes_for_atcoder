import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias W = Tuple!(int, "i", int, "s", int, "t");
alias P = Tuple!(int, "to", bool, "used");

void main()
{
    auto N = readln.chomp.to!int;
    W[] ws;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        ws ~= W(i, ab[0], ab[1]);
    }
    sort!"a.s == b.s ? a.t < b.t : a.s < b.s"(ws);
    auto DP = new int[](N);
    auto used = new bool[](N);
    int solve(int i) {
        if (i == N) return 0;
        auto x = ws[i].i;
        if (DP[x] == 0) {
            auto r1 = solve(i+1);

            auto l = i.to!int, r = N;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (ws[m].s >= ws[i].t) {
                    r = m;
                } else {
                    l = m;
                }
            }
            auto r2 = solve(r) + 1;
            if (r1 > r2) {
                DP[x] = r1;
            } else {
                DP[x] = r2;
                used[x] = true;
            }
        }
        return DP[x];
    }
    auto n = solve(0);
    writeln(n);
    auto vs = new W[][n];
    sort!"a.i < b.i"(ws);
    foreach (i; 0..N) if (used[i]) {
        vs[DP[i]-1] ~= ws[i];
    }
    int t;
    int[] rs;
    foreach_reverse (s; 0..n) {
        while (vs[s][0].s < t) {
            vs[s] = vs[s][1..$];
        }
        rs ~= vs[s][0].i + 1;
        t = vs[s][0].t;
    }
    writeln(rs.to!(string[]).join(" "));
}