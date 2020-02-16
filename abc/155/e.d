import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    auto DP = new long[][](N.length, 2);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, bool k) {
        if (i == N.length) return k == 0 ? 0 : long.max/3;
        if (DP[i][k] == -1) {
            long n = N[i]-'0';
            if (k) {
                DP[i][k] = min(solve(i+1, 0) + 10 - n, solve(i+1, 1) + 10 - n - 1);
            } else {
                DP[i][k] = min(solve(i+1, 0) + n, solve(i+1, 1) + n + 1);
            }
        }
        return DP[i][k];
    }
    writeln(min(solve(0, 0), solve(0, 1) + 1));
}