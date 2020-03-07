import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] AS;
    foreach (i; 0..N) {
        AS ~= readln.chomp.to!long;
    }

    auto DP = new long[][][](N, N, 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    long solve(int i, int j, int t) {
        if (i == j) return t == 0 ? 0 : AS[i];

        if (DP[i][j][t] == -1) {
            if (t == 0) {
                DP[i][j][t] = AS[i] > AS[j] ? solve((i+1)%N, j, 1) : solve(i, j-1 < 0 ? N-1 : j-1, 1);
            } else {
                DP[i][j][t] = max(solve((i+1)%N, j, 0) + AS[i], solve(i, j-1 < 0 ? N-1 : j-1, 0) + AS[j]);
            }
        }
        return DP[i][j][t];
    }

    long r;
    foreach (i; 0..N) {
        r = max(r, AS[i] + solve((i+1)%N, i-1 < 0 ? N-1 : i-1, 0));
    }
    writeln(r);
}