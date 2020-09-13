import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    auto DP = new long[][](N+1, 4);
    DP[0][0] = 1;
    foreach (i; 0..N) {
        (DP[i+1][0] += DP[i][0] * 8 % P) %= P;
        (DP[i+1][1] += DP[i][0] + DP[i][1] * 9 % P) %= P;
        (DP[i+1][2] += DP[i][0] + DP[i][2] * 9 % P) %= P;
        (DP[i+1][3] += DP[i][1] + DP[i][2] + DP[i][3] * 10 % P) %= P;
    }
    writeln(DP[N][3]);
}