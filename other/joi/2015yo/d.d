import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    long[] cs, ds;
    foreach (_; 0..N) ds ~= readln.chomp.to!long;
    foreach (_; 0..M) cs ~= readln.chomp.to!long;

    auto DP = new long[][](N+1, M+1);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (j; 0..M) {
            DP[i][j+1] = min(DP[i][j+1], DP[i][j]);
            DP[i+1][j+1] = min(DP[i+1][j+1], DP[i][j] + cs[j] * ds[i]);
        }
    }
    auto r = long.max;
    foreach (rr; DP[N]) r = min(r, rr);
    writeln(r);
}