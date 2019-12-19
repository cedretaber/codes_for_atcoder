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
    
    long buy(int i, long res, ulong state) {
        if (i == N) return 0;
        if (state&(1<<i) || res < cs[i]) return buy(i+1, res, state);
        return max(buy(i+1, res, state), vs[i] + buy(i+1, res - cs[i], state));
    }

    long[] dp;
    dp.length = 1 << N;
    dp[] -= 1;
    long solve(int i, ulong state) {
        if (i == N-1) return 0;
        if (dp[state] != -1) return dp[state];
        Tuple!(int, long, long)[] list;
        list.length = N;
        foreach (ref e; list) e[0] = -1;
        foreach (j; 0..N) {
            if (state & (1<<j)) continue;
            list[j][0] = j;
            list[j][1] = buy(0, money[i+1], state | (1<<j));
            list[j][2] = vs[j];
        }
        list.sort!"a[0] == -1 ? false : b[0] == -1 ? true : a[1] == b[1] ? a[2] > b[2] : a[1] < b[1]";

        auto min_p = long.max;
        foreach (ref e; list[0..(7 > $ ? $ : 7)]) {
            if (e[0] == -1) break;
            min_p = min(min_p, solve(i+1, state | (1<<(e[0]))));
        }

        return dp[state] = max(buy(0, money[i], state), min_p);
    }

    writeln(solve(0, 0));
}