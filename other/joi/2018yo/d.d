import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias MM = Tuple!(int, "max", int, "min");

void main()
{
    auto N = readln.chomp.to!int;
    int[] LS;
    LS.length = N;
    foreach (i; 0..N) LS[i] = readln.chomp.to!int;
    int[] CS;
    CS.length = N;
    foreach (i; 0..N) {
        if (i == 0) {
            CS[i] = LS[i];
        } else {
            CS[i] = CS[i-1] + LS[i];
        }
    }

    auto DP = new MM[][][](N, N, N+1);
    MM solve(int s, int t, int c) {
        if (DP[s][t][c].min) return DP[s][t][c];
        auto r = MM(-1, -1);
        if (c == 1) {
            auto x = CS[t];
            if (s > 0) x -= CS[s-1];
            r = MM(x, x);
        } else if (s != t) {
            foreach (i; s..t) {
                if (c%2 == 1) {
                    auto r1 = solve(s, i, c/2+1);
                    auto r2 = solve(i+1, t, c/2);
                    auto r3 = solve(s, i, c/2);
                    auto r4 = solve(i+1, t, c/2+1);
                    if (r1.min != -1 && r2.min != -1) {
                        auto r5 = MM(max(r1.max, r2.max), min(r1.min, r2.min));
                        if (r.max == -1 || r5.max - r5.min < r.max - r.min) r = r5;
                    }
                    if (r3.min != -1 && r4.min != -1) {
                        auto r6 = MM(max(r3.max, r4.max), min(r3.min, r4.min));
                        if (r.max == -1 || r6.max - r6.min < r.max - r.min) r = r6;
                    }
                } else {
                    auto r1 = solve(s, i, c/2);
                    auto r2 = solve(i+1, t, c/2);
                    if (r1.min != -1 && r2.min != -1) {
                        auto r3 = MM(max(r1.max, r2.max), min(r1.min, r2.min));
                        if (r.max == -1 || r3.max - r3.min < r.max - r.min) r = r3;
                    }
                }
            }
        }
        DP[s][t][c] = r;
        return r;
    }

    int r = int.max;
    foreach (i; 2..N+1) {
        auto x = solve(0, N-1, i);
        if (x.min != -1) r = min(r, x.max - x.min);
    }
    writeln(r);
}