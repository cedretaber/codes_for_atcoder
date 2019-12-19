import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto xs = readln.split.to!(long[]);
    auto cs = readln.split.to!(long[]);
    auto vs = readln.split.to!(long[]);

    long[] css;
    css.length = N;

    long buy(int j, long res, long S) {
        if (j == N) return 0;
        if (S & (1<<j) || res < cs[j]) return buy(j+1, res, S);
        return max(buy(j+1, res, S), vs[j] + buy(j+1, res - cs[j], S));
    }

    long money, max_p;
    ulong E = ~((1 << N) - 1);
    foreach (i; 0..N) {
        money += xs[i];
        auto min_p = long.max;
        ulong S = (1 << (i+1)) - 1;
        while (!(S & E)) {
            min_p = min(min_p, buy(0, money, S));
            auto smallest = S & -S;
            auto ripple = S + smallest;
            auto nsmallest = ripple & -ripple;
            S = ripple | (((nsmallest / smallest) >> 1) - 1);
        }
        max_p = max(max_p, min_p);
    }

    writeln(max_p);
}