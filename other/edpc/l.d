import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    long[][] DP;
    DP.length = N;
    foreach (ref dp; DP) dp.length = N;

    auto x = (N-1)%2;
    long solve(int i, int j) {
        if (i > j) return 0;
        if (DP[i][j]) return DP[i][j];

        if ((i+j)%2 == x) {
            return DP[i][j] = max(solve(i+1, j) + as[i], solve(i, j-1) + as[j]);
        } else {
            return DP[i][j] = min(solve(i+1, j) - as[i], solve(i, j-1) - as[j]);
        }
    }

    writeln(solve(0, N-1));
}