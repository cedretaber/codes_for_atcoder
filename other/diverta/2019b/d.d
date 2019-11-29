import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[] AS, BS;

void main()
{
    auto N = readln.chomp.to!long;
    AS = readln.split.to!(long[]);
    BS = readln.split.to!(long[]);

    long[][3] DP;
    foreach (ref dp; DP) dp.length = N+1;
    foreach_reverse (j; 0..N+1) {
        foreach_reverse (i; 0..3) {
            long r1, r2;
            r1 = i == 2 ? N-j : DP[i+1][j];
            if (j+AS[i] <= N) {
                r2 = DP[i][j+AS[i]] + BS[i];
            }
            DP[i][j] = max(r1, r2);
        }
    }
    auto M = DP[0][0];
    foreach (ref dp; DP) {
        dp[] = 0;
        dp.length = M+1;
    }
    foreach_reverse (j; 0..M+1) {
        foreach_reverse (i; 0..3) {
            long r1, r2;
            r1 = i == 2 ? M-j : DP[i+1][j];
            if (j+BS[i] <= M) {
                r2 = DP[i][j+BS[i]] + AS[i];
            }
            DP[i][j] = max(r1, r2);
        }
    }

    writeln(DP[0][0]);
}