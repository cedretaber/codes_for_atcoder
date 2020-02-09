import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    auto K = readln.chomp.to!int;

    auto DP = new long[][][](2, K+1, N.length);
    DP[1][K-1][0] += 1;
    foreach (x; 1..N[0]-'0') DP[0][K-1][0] += 1;
    foreach (i; 1..N.length) {
        if (N[i] == '0') {
            foreach (k; 0..K+1) DP[1][k][i] += DP[1][k][i-1];
        } else {
            foreach (k; 1..K+1) DP[1][k-1][i] += DP[1][k][i-1];
            foreach (k; 0..K+1) DP[0][k][i] += DP[1][k][i-1];
        }
        foreach (k; 1..K+1) DP[0][k-1][i] += DP[1][k][i-1] * max(0, (N[i]-'0').to!long-1);

        foreach (k; 1..K+1) DP[0][k-1][i] += DP[0][k][i-1] * 9;
        foreach (k; 0..K+1) DP[0][k][i] += DP[0][k][i-1];
        DP[0][K-1][i] += 9;
    }
    long r;
    foreach (x; 0..2) r += DP[x][0][N.length-1];
    writeln(r);
}