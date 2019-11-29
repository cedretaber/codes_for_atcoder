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
    
    long[uint][20] memo;
    long buy(int i, uint state) {
        if (state in memo[i]) return memo[i][state];
        long all_c, all_v;
        foreach (j; 0..N) if ((~state) & (1<<j)) {
            all_c += cs[j];
            all_v += vs[j];
        }
        if (all_c <= money[i]) return memo[i][state] = all_v;
        long max_v;
        foreach (j; 0..N) {
            if (state & (1<<j)) continue;
            max_v = max(max_v, buy(i, state | (1<<j)));
        }
        return memo[i][state] = max_v;
    }
 
    long[uint] dp;
    long solve(int i, uint state) {
        if (i == N) return 0;
        if (state in dp) return dp[state];
        auto max_p = buy(i, state);
        auto min_p = long.max;
        foreach (j; 0..N) {
            if (state & (1<<j)) continue;
            min_p = min(min_p, solve(i+1, state | (1<<j)));
        }
        return dp[state] = max(max_p, min_p);
    }
 
    writeln(solve(0, 0));
}