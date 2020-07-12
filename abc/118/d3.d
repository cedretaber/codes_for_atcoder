import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum MM = [0,2,5,5,4,5,6,3,7,6];

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ms = new bool[](11);
    foreach (a; readln.split.to!(int[])) ms[a] = true;

    int[] max_rs(int[] aa, int[] bb) {
        int ac, bc;
        foreach (a; aa) ac += a;
        foreach (b; bb) bc += b;
        if (ac > bc) {
            return aa;
        } else if (ac < bc) {
            return bb;
        }
        foreach_reverse (i; 1..10) {
            if (aa[i] > bb[i]) {
                return aa;
            } else if (aa[i] < bb[i]) {
                return bb;
            }
        }
        return aa;
    }

    auto DP = new int[][][](10, N+1, 0);
    auto ng = new int[](11);
    ng[0] = -1;
    int[] solve(int i, int n) {
        if (i == 10) return n == 0 ? new int[](11) : ng;
        if (DP[i][n].empty) {
            if (ms[i] && n >= MM[i]) {
                auto r1 = solve(i+1, n);
                auto r2 = solve(i, n-MM[i]).dup;
                r2[i] += 1;
                DP[i][n] = max_rs(r1, r2);
            } else {
                DP[i][n] = solve(i+1, n);
            }
        }
        return DP[i][n];
    }

    int[] res;
    foreach_reverse (i, n; solve(1, N)) if (n) {
        foreach (_; 0..n) res ~= i.to!int;
    }
    writeln(res.to!(string[]).join(""));
}