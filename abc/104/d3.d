import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto S = readln.chomp;
    auto DP = new long[][](S.length+1, 4);
    DP[S.length][3] = 1;
    foreach_reverse (i; 0..S.length) {
        auto c = S[i];
        foreach (j; 0..4) {
            if (c == 'A' || c == '?') {
                DP[i][j] = (DP[i][j] + DP[i+1][j]) % P;
                if (j == 0) DP[i][j] = (DP[i][j] + DP[i+1][j+1]) % P;
            }
            if (c == 'B' || c == '?') {
                DP[i][j] = (DP[i][j] + DP[i+1][j]) % P;
                if (j == 1) DP[i][j] = (DP[i][j] + DP[i+1][j+1]) % P;
            }
            if (c == 'C' || c == '?') {
                DP[i][j] = (DP[i][j] + DP[i+1][j]) % P;
                if (j == 2) DP[i][j] = (DP[i][j] + DP[i+1][j+1]) % P;
            }
        }
    }
    writeln(DP[0][0]);
}