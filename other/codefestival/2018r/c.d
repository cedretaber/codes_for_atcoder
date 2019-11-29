import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nh = readln.split.to!(int[]);
    auto N = nh[0];
    auto H = nh[1];
    auto hs = new int[](N);
    foreach (i; 0..N) hs[i] = readln.chomp.to!int;

    auto memo = new int[](1<<N);
    memo[] = -1;
    memo[0] = 1;
    int solve(uint s) {
        if (memo[s] != -1) return memo[s];
        int r, h;
        foreach (i; 0..N) if (s & (1<<i)) {
            h += hs[i];
            if (h <= H) r += solve(s & ~(1<<i));
        }
        memo[s] = r;
        return r;
    }

    writeln(solve((1<<N)-1));
}