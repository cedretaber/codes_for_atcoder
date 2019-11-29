import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum P = 10L^^9+7;

int[10^^5] DS;
long[4][10^^5] DP;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        DS[i] = readln.chomp.to!int;
    }
    sort(DS[0..N]);

    size_t k;
    DP[0][0] = 1;
    foreach (i; 0..N) {
        while (k < N && DS[k] < DS[i]*2) ++k;
        foreach (j; 0..4) {
            if (i) DP[i][j] = (DP[i][j] + DP[i-1][j]) % P;
            if (j < 3 && k < N) DP[k][j+1] = (DP[k][j+1] + DP[i][j]) % P;
        }
    }

    long r;
    foreach (i; 0..N) r = (r + DP[i][3]) % P;
    writeln(r);
}