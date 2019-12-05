import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] RS;
    RS.length = N;
    foreach (i; 0..N) RS[i] = readln.split.to!(int[]);

    auto DP = new long[][](N, 2^^N);
    foreach (ref dp; DP) foreach (ref e; dp) e = -1;
    long solve(int i, uint s) {
        if (i == N) return 1;
        if (DP[i][s] == -1) {
            long x;
            foreach (j; 0..N) {
                if ((s & (1<<j)) == 0 && RS[i][j]) x = (x + solve(i+1, s | (1<<j))) % P;
            }
            DP[i][s] = x;
        }
        return DP[i][s];
    }
    writeln(solve(0, 0));
}