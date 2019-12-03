import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias C = Tuple!(int, "x", int, "v", int, "d", int, "n");

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    auto L = nl[1];
    auto vd = readln.split.to!(int[]);
    auto V = vd[0];
    auto D = vd[1];

    auto cs = new C[](N+2);
    cs[0] = C(0, V, D, 0);
    foreach (i; 1..N+1) {
        auto xvd = readln.split.to!(int[]);
        cs[i] = C(xvd[0], xvd[1], xvd[2], 0);
    }
    cs[N+1] = C(L, 0, 0, 0);
    sort!"a.x < b.x"(cs);
    foreach (i; 0..N+1) {
        foreach (j; i+1..N+2) {
            if (cs[j].x <= cs[i].x + cs[i].d) {
                cs[i].n = j;
            } else {
                break;
            }
        }
    }

    auto DP = new double[][](N+1, N+1);
    double solve(int i, int x) {
        if (i == N+1) return cs[x].n == N+1 ? 0 : double.infinity;
        if (isNaN(DP[i][x])) {
            if (cs[x].n < i) {
                DP[i][x] = double.infinity;
            } else {
                auto d = (cs[i+1].x - cs[i].x).to!double;
                auto r1 = solve(i+1, x) + d / cs[x].v.to!double;
                auto r2 = solve(i+1, i) + d / cs[i].v.to!double;
                DP[i][x] = min(r1, r2);
            }
        }
        return DP[i][x];
    }
    auto r = solve(0, 0);
    if (isInfinity(r)) {
        writeln("impossible");
    } else {
        writefln("%.010f", r);
    }
}