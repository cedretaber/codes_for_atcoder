import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto xs = readln.split.to!(long[]);
    auto cs = readln.split.to!(long[]);
    auto vs = readln.split.to!(long[]);

    long[] money;
    money.length = N;
    foreach (i; 0..N-1) {
        money[i+1] = money[i] + xs[i];
    }
    
    long[long][ulong] memo;
    long buy(int i, long res, ulong state) {
        if (i == N) return 0;
        auto key = state | ((1<<i)-1);
        if (key in memo && res in memo[key]) return memo[key][res];
        if (state&(1<<i) || res < cs[i]) return memo[key][res] = buy(i+1, res, state);
        return memo[key][res] = max(buy(i+1, res, state), vs[i] + buy(i+1, res - cs[i], state));
    }

    long[ulong] dp;
    long solve(int i, ulong state) {
        if (i == N) return 0;
        if (state in dp) return dp[state];
        auto max_p = buy(0, money[i], state);
        auto min_p = long.max;
        foreach (j; 0..N) {
            if (state & (1<<j)) continue;
            min_p = min(min_p, solve(i+1, state | (1<<j)));
        }
        return dp[state] = max(max_p, min_p);
    }

    writeln(solve(0, 0));
}