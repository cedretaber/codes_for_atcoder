import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    long K = nk[1];
    auto cs = new long[](N);
    int sum_c;
    foreach (i, a; readln.split.to!(long[])) {
        int c;
        while (a) {
            ++c;
            a /= 2;
        }
        cs[i] = c;
        sum_c += c;
    }
    if (K >= sum_c) {
        long x = 1, y = 1;
        foreach (c; cs) {
            x = (x * (c + 1)) % P;
            y = (y * c) % P;
        }
        writeln((x - y + P) % P);
    } else {
        auto DP = new long[][][](N+1, K+1, 2);
        long solve(int i, long k, int z) {
            if (i == N) return k == 0 || z == 1 ? 1 : 0;
            if (DP[i][k][z]) return DP[i][k][z];

            long r;
            foreach (c; 0..cs[i]+1) {
                if (k-c < 0) break;
                r = (r + solve(i+1, k-c, c == cs[i] ? 1 : z)) % P;
            }
            DP[i][k][z] = r;
            return r;
        }
        writeln(solve(0, K, 0));
    }
}