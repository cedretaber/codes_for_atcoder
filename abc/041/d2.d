import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto cs = new uint[](N);
    foreach (i; 0..M) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        cs[y] |= 1<<x;
    }

    auto DP = new long[](1<<N);
    DP[] = -1;
    long solve(uint s) {
        if (s == (1<<N)-1) return 1;
        if (DP[s] == -1) {
            DP[s] = 0;
            foreach (i; 0..N) if ((s&(1<<i)) == 0 && (s&cs[i]) == cs[i]) {
                DP[s] += solve(s | (1<<i));
            }
        }
        return DP[s];
    }
    writeln(solve(0));
}