import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[11] NS = [59049, 46656, 7776, 6561, 1296, 729, 216, 81, 36, 9, 6];

void  main()
{
    auto N = readln.chomp.to!int;

    int[int][11] memo;
    int solve(int i, int n) {
        if (n == 0) return 0;
        if (i == 11) return n;
        if (n in memo[i]) return memo[i][n];

        if (n < NS[i]) {
            return memo[i][n] = solve(i+1, n);
        } else {
            return memo[i][n] = min(solve(i+1, n), solve(i, n - NS[i]) + 1);
        }
    }

    writeln(solve(0, N));
}