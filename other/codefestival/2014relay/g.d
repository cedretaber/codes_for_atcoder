import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] as;
    foreach (_; 0..N) as ~= readln.chomp.to!int;

    auto DP = new int[][](N, 10_000 * N + 1);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int i, int a) {
        if (i == N) return a >= M ? a : int.max/3;
        if (DP[i][a] == -1) {
            DP[i][a] = min(solve(i+1, a), solve(i+1, a + as[i]));
        }
        return DP[i][a];
    }
    auto r = solve(0, 0);
    writeln(r == int.max/3 ? -1 : r);
}