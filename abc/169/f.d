import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 998244353L;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    auto ns = readln.split.to!(int[]);
    auto N = ns[0];
    auto S = ns[1];
    auto AS = readln.split.to!(int[]);

    auto DP = new long[][](N+1, S+1);
    foreach (ref dp; DP) dp[] = -1;

    long r;
    long solve(int i, int s, long j) {
        if (i == N) return s == S ? 0 : -2;
        if (DP[i][s] == -1) {
            solve(i+1, s, j);
            if (s + AS[i] == S) {
                DP[i][s] = 0;
            } else if (s + AS[i] <= S) {
                DP[i][s] = solve(i+1, s + AS[i], j+1);
            } else {
                DP[i][s] = -2;
            }
        }
        if (DP[i][s] != -2) (r += pow(2, N - j - DP[i][s]) % P) %= P;
        return DP[i][s] + 1;
    }
    solve(0, 0, 1);
    writeln(DP);
    writeln(r);
}