import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto mn = readln.split.to!(int[]);
    auto M = mn[0];
    auto N = mn[1];
    int[] PS, CS, ES;
    foreach (_; 0..M) PS ~= readln.chomp.to!int;
    foreach (_; 0..N) {
        auto ce = readln.split.to!(int[]);
        CS ~= ce[0];
        ES ~= ce[1];
    }

    sort!"a > b"(PS);
    foreach (i; 1..M) PS[i] += PS[i-1];

    auto DP = new int[][](N+1, M+1);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (j; 0..M+1) {
            DP[i+1][j] = min(DP[i+1][j], DP[i][j]);
            auto jj = min(M, j + CS[i]);
            DP[i+1][jj] = min(DP[i+1][jj], DP[i][j] + ES[i]);
        }
    }

    int r;
    foreach (i; 0..M) r = max(r, PS[i] - DP[N][i+1]);
    writeln(r);
}