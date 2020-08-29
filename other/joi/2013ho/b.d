import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto S = readln.chomp.to!(char[]);
    S.reverse();
    auto T = readln.chomp.to!(char[]);
    T.reverse();

    auto DP = new int[][][](N+1, M+1, 2);
    foreach (i; 0..N+1) foreach (j; 0..M+1) {
        if (i < N && S[i] == 'I') DP[i+1][j][0] = max(DP[i+1][j][0], 1);
        if (j < M && T[j] == 'I') DP[i][j+1][1] = max(DP[i][j+1][1], 1);
        
        if (i > 0) {
            auto s = S[i-1];
            if (i < N && s != S[i]) DP[i+1][j][0] = max(DP[i+1][j][0], DP[i][j][0] + 1);
            if (j < M && s != T[j]) DP[i][j+1][1] = max(DP[i][j+1][1], DP[i][j][0] + 1);
        }
        if (j > 0) {
            auto t = T[j-1];
            if (i < N && t != S[i]) DP[i+1][j][0] = max(DP[i+1][j][0], DP[i][j][1] + 1);
            if (j < M && t != T[j]) DP[i][j+1][1] = max(DP[i][j+1][1], DP[i][j][1] + 1);
        }
    }
    
    int r;
    foreach (i; 1..N+1) foreach (j; 1..M+1) {
        if (S[i-1] == 'I') r = max(r, DP[i][j][0]);
        if (T[j-1] == 'I') r = max(r, DP[i][j][1]);
    }
    writeln(r);
}