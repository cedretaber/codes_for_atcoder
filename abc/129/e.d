import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[2][10^^5+10] DP;

void main()
{
    auto L = readln.chomp.to!(char[]);

    DP[0][1] = 2;
    DP[0][0] = 1;
    foreach (i; 1..L.length) {
        if (L[i] == '0') {
            DP[i][1] = DP[i-1][1];
            DP[i][0] = (DP[i-1][0] * 3) % P;
        } else {
            DP[i][1] = (DP[i-1][1] * 2) % P;
            DP[i][0] = (DP[i-1][1] + DP[i-1][0] * 3) % P;
        }
    }
    writeln((DP[L.length-1][0] + DP[L.length-1][1]) % P);
}