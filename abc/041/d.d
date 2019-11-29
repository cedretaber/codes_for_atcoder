import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[uint] MEMO;
uint[16] BS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0] - 1;
        auto y = xy[1] - 1;
        BS[y] |= (1<<x);
    }

    long solve(uint s) {
        if (s == (1<<N)-1) return 1;
        if (s in MEMO) return MEMO[s];
        MEMO[s] = 0;
        foreach (i; 0..N) {
            if (s & (1<<i)) continue;
            if ((BS[i] & s) != BS[i]) continue;
            MEMO[s] += solve(s | (1<<i));
        }
        return MEMO[s];
    }

    writeln(solve(0));
}