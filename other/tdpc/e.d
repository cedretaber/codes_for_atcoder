import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto D = readln.chomp.to!int;
    auto N = readln.chomp;
    auto len = N.length;

    auto DP = new long[][][](2, D, 2);
    auto t = N[0] - '0';
    DP[1][t%D][0] = 1;
    foreach (n; 0..t) DP[0][n%D][0] += 1;

    foreach (i; 1..len) {
        foreach (c; 0..D) {
            DP[1][c][i%2] = 0;
            DP[0][c][i%2] = 0;
        }
        auto m = N[i] - '0';
        foreach (p; 0..D) {
            DP[1][(p+m)%D][i%2] = (DP[1][(p+m)%D][i%2] + DP[1][p][(i+1)%2]) % P;
            foreach (x; 0..m) DP[0][(p+x)%D][i%2] = (DP[0][(p+x)%D][i%2] + DP[1][p][(i+1)%2]) % P;
            foreach (x; 0..10) DP[0][(p+x)%D][i%2] = (DP[0][(p+x)%D][i%2] + DP[0][p][(i+1)%2]) % P;
        }
    }

    writeln((DP[1][0][(len+1)%2] + DP[0][0][(len+1)%2] - 1 + P) % P);
}