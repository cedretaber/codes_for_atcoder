import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto X = readln.chomp;
    auto x = X.length;
    auto S = readln.chomp;
    auto s = S.length;
    auto T = readln.chomp;
    auto t = T.length;

    auto DP = new long[][][](x+1, max(s, t), 2);
    DP[0][0][0] = 1;
    DP[0][0][1] = 1;
    foreach (i; 0..x) {
        foreach (j; 0..s-1) {
            if (X[i] == S[j]) (DP[i+1][j+1][0] += DP[i][j][0]) %= P;
        }
        if (X[i] == S[s-1]) {
            (DP[i+1][0][0] += DP[i][s-1][0]) %= P;
            (DP[i+1][0][1] += DP[i][s-1][0]) %= P;
        }
        foreach (j; 0..t-1) {
            if (X[i] == T[j]) (DP[i+1][j+1][1] += DP[i][j][1]) %= P;
        }
        if (X[i] == T[t-1]) {
            (DP[i+1][0][0] += DP[i][t-1][1]) %= P;
            (DP[i+1][0][1] += DP[i][t-1][1]) %= P;
        }
    }
    writeln((DP[x][0][0] + DP[x][0][1]) % P * 500000004 % P);
}