import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum PS = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];

void main()
{
    auto ab = readln.split.to!(long[]);
    auto A = ab[0];
    auto B = ab[1];
    auto DP = new long[][](B-A+1, 2^^11);
    long solve(long d, int s) {
        auto x = A + d;
        if (x == B+1) return 1;
        if (DP[d][s]) return DP[d][s];
        uint t = s;
        foreach (i, p; PS) if (x%p == 0) {
            if (s&(1<<i)) {
                DP[d][s] = solve(d+1, s);
                return DP[d][s];
            }
            t |= 1<<i;
        }
        DP[d][s] = solve(d+1, s) + solve(d+1, t);
        return DP[d][s];
    }
    writeln(solve(0, 0));
}