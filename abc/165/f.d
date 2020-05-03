import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    int[][] T;
    T.length = N;
    foreach (_; 1..N) {
        auto uv = readln.split.to!(int[]);
        auto u = uv[0]-1;
        auto v = uv[1]-1;
        T[u] ~= v;
        T[v] ~= u;
    }
    auto res = new int[](N);
    auto DP = new int[](N);
    DP[] = int.max;
    size_t idx;

    void solve(int i, int p) {
        auto a = as[i];
        size_t len = idx, pi;
        int pa;
        if (idx == 0 || DP[idx-1] < a) {
            DP[idx++] = a;
        } else if (DP[0] >= a) {
            pa = DP[0];
            DP[0] = a;
        } else {
            size_t l, r = idx-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (DP[m] >= a) {
                    r = m;
                } else {
                    l = m;
                }
            }
            pi = r;
            pa = DP[r];
            DP[r] = a;
        }
        res[i] = idx.to!int;

        foreach (j; T[i]) if (j != p) solve(j, i);

        if (idx != len) {
            idx = len;
        } else {
            DP[pi] = pa;
        }
    }

    solve(0, -1);
    foreach (r; res) writeln(r);
}