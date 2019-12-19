import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

long[long][ulong] memo;
long[ulong] dp;

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
    
    long buy(long res, ulong state) {
        if (state == (1<<(N+1))-1) return 0;
        if (state in memo && res in memo[state]) return memo[state][res];
        long c, v;
        foreach (j; 0..N) if (!(state & (1<<j))) {
            c += cs[j];
            v += vs[j];
        }
        if (c > res) {
            v = 0;
            foreach (j; 0..N) {
                if (state & (1<<j)) continue;
                v = max(v, buy(res, state | (1<<j)));
            }
        }
        return memo[state][res] = v;
    }

    long solve(int i, ulong state) {
        if (i == N) return 0;
        if (state in dp) return dp[state];
        auto max_p = buy(money[i], state);
        auto min_p = long.max;
        foreach (j; 0..N) {
            if (state & (1<<j)) continue;
            min_p = min(min_p, solve(i+1, state | (1<<j)));
        }
        return dp[state] = max(max_p, min_p);
    }

    writeln(solve(0, 0));
}