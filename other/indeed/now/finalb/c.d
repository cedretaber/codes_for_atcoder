import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(dchar[]);
    auto CS = readln.split.to!(long[]);

    auto PP = new bool[][](N, N);
    foreach (i; 0..N) PP[i][i] = true;
    foreach (i; 0..N-1) if (S[i] == S[i+1]) PP[i][i+1] = true;
    foreach (w; 2..N) {
        foreach (i; 0..N) {
            auto j = i+w;
            if (j >= N || S[i] != S[j] || !PP[i+1][j-1]) continue;
            PP[i][j] = true;
        }
    }
    auto DP = new long[](N+1);
    DP[] = long.max/3;
    DP[0] = 0;
    foreach (i; 0..N) {
        foreach (j; i+1..N+1) {
            if (PP[i][j-1]) {
                DP[j] = min(DP[j], DP[i] + CS[j-i-1]);
            }
        }
    }
    writeln(DP[N]);
}