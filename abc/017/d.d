import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10^^9L+7;

int[10^^5+1] FS;
long[10^^5+1] DP;
bool[10^^5+1] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 1..N+1) FS[i] = readln.chomp.to!int;
    int i, j = 1;
    long s = 1;
    DP[0] = 1;
    while (j < N+1) {
        while (MEMO[FS[j]]) {
            MEMO[FS[i]] = false;
            s = (s - DP[i++] + P) % P;
        }
        DP[j] = (s + (i > 0 ? DP[i-1] : 0)) % P;
        MEMO[FS[j]] = true;
        s = (s + DP[j++]) % P;
    }
    writeln(DP[N]);
}