import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[10^^5] XS;
long[10^^5] VS;

void main()
{
    auto nc = readln.split.to!(long[]);
    auto N = nc[0];
    auto C = nc[1];

    foreach (i; 0..N) {
        auto xv = readln.split.to!(long[]);
        XS[i] = xv[0];
        VS[i] = xv[1];
    }

    long[long] memo;
    long solve(long cnt, long i) {
        auto v = i >= 0 ? VS[i] : VS[N+i];
        if (cnt == N) return v;

        auto key = i < 0 ? i*10^^6-cnt : i*10^^6+cnt;
        if (key in memo) return memo[key];

        long w, x;
        if (i >= 0) {
            w = v + solve(cnt+1, i+1) - (XS[i+1] - XS[i]);
            x = v + solve(cnt+1, i-cnt) - (XS[i] + C - XS[N+i-cnt]);
        } else {
            w = v + solve(cnt+1, i+cnt) - (XS[i+cnt] + C - XS[N+i]);
            x = v + solve(cnt+1, i-1) - (XS[N+i] - XS[N+i-1]);
        }

        return memo[key] = max(v, w, x);
    }

    writeln(max(solve(1, 0) - XS[0], solve(1, -1) - (C - XS[N-1]), 0));
}