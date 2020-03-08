import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum cs = [6,36,216,1296,7776,46656,279936,9,81,729,6561,59049,531441];

void main()
{
    auto N = readln.chomp.to!int;

    auto DP = new int[][](cs.length, N+1);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, int n) {
        if (i == cs.length) return n;

        if (DP[i][n] == -1) {
            if (n >= cs[i]) {
                DP[i][n] = min(solve(i+1, n), solve(i, n-cs[i]) + 1);
            } else {
                DP[i][n] = solve(i+1, n);
            }
        }
        return DP[i][n];
    }
    writeln(solve(0, N));
}