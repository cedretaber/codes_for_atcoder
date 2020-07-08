import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 998244353L;

void main()
{
    auto abcd = readln.split.to!(long[]);
    auto A = abcd[0];
    auto B = abcd[1];
    auto C = abcd[2];
    auto D = abcd[3];
    auto DP = new long[][][](C+1, D+1, 2);
    DP[A][B][0] = 1;
    foreach (i; A..C+1) {
        foreach (j; B..D+1) {
            if (i == A && j == B) continue;
            DP[i][j][0] = (DP[i][j-1][0] * i % P + DP[i][j-1][1]) % P;
            DP[i][j][1] = (DP[i-1][j][0] + DP[i-1][j][1]) * j % P;
        }
    }
    writeln((DP[C][D][0] + DP[C][D][1]) % P);
}