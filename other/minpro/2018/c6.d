import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto xs = readln.split.to!(long[]);
    auto cs = readln.split.to!(long[]);
    auto vs = readln.split.to!(long[]);

    long[long][1<<18][] memo;
    memo.length = N;
    long solve(int i, long res, ulong state) {
        if (i == N) return 0;
        if (res in memo[i][state]) return memo[i][state][res];
        if (state & (1<<i) || res < cs[i]) return memo[i][state][res] = solve(i+1, res, state);
        return memo[i][state][res] = max(solve(i+1, res, state), vs[i] + solve(i+1, res - cs[i], state));
    }

    long money;
    ulong E = ~((1 << N) - 1);
    foreach (i; 0..N) {

        money += xs[i];
        ulong S = (1 << (i+1)) - 1;
        while (!(S & E)) {
            solve(0, money, S);
            auto smallest = S & -S;
            auto ripple = S + smallest;
            auto nsmallest = ripple & -ripple;
            S = ripple | (((nsmallest / smallest) >> 1) - 1);
        }
    }
}