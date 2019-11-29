import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto DP = new long[][](S.length, 13);

    foreach (i, c; S) {
        foreach (n; 0..10) {
            if (c == '?' || n == c-'0') {
                if (i == 0) {
                    DP[i][n] = 1;
                } else {
                    foreach (j; 0..13) {
                        auto m = (j*10 + n) % 13;
                        DP[i][m] = (DP[i][m] + DP[i-1][j]) % P;
                    }
                }
            }
        }
    }

    writeln(DP[$-1][5]);
}