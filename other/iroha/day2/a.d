import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto T = readln.chomp.to!(char[]);
    auto len = S.length;

    int[][] dp;
    dp.length = len + 1;
    foreach (ref l; dp) l.length = len + 1;

    int max_c;
    foreach_reverse (i; 0..len) {
        foreach_reverse (j; 0..len) {
            if (S[i] == T[j]) {
                dp[i][j] = dp[i+1][j+1] + 1;
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j+1]);
            }
            max_c = max(max_c, dp[i][j]);
        }
    }
    writeln(max_c + 1);
}