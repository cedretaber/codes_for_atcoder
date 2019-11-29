import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto DP = new long[][][](1000, 1000, 3);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto SS = new int[](M);
    foreach (i; 0..M) {
        auto S = readln.chomp;
        SS[i] = S == "Fizz" ? 0 : S == "Buzz" ? 1 : 2;
    }

    long solve(int i, int k, int m) {
        if (k == N) return i == M ? 1 : 0;
        if (DP[i][k][m] != -1) return DP[i][k][m];

        long r;
        foreach (j; 1..10) if ((m+j)%3 != 0 && j != 5) r = (r + solve(i, k+1, (m+j)%3)) % P;
        if (i < M) {
            switch (SS[i]) {
                case 0:
                    foreach (j; 1..10) if ((m+j)%3 == 0 && j != 5) r = (r + solve(i+1, k+1, (m+j)%3)) % P;
                    break;
                case 1:
                    if (m%3 != 0) r = (r + solve(i+1, k+1, m)) % P;
                    if ((m+5)%3 != 0) r = (r + solve(i+1, k+1, (m+5)%3)) % P;
                    break;
                default:
                    if (m == 0 && k != 0) r = (r + solve(i+1, k+1, 0)) % P;
                    if ((m+5)%3 == 0) r = (r + solve(i+1, k+1, 0)) % P;
            }
        }
        DP[i][k][m] = r;
        return r;
    }
    writeln(solve(0, 0, 0));
}