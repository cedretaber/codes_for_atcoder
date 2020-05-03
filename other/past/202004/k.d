import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto CS = readln.split.to!(long[]);
    auto DS = readln.split.to!(long[]);
    auto DP = new long[][](N+1, N+1);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][0] = 0;
    
    foreach (i; 0..N) {
        DP[i+1][0] = min(DP[i+1][0], DP[i][0] + DS[i]);
        if (S[i] == ')') {
            DP[i+1][1] = min(DP[i+1][1], DP[i][0] + CS[i]);
        } else {
            DP[i+1][1] = min(DP[i+1][1], DP[i][0]);
        }
        foreach (j; 1..N) {
            DP[i+1][j] = min(DP[i+1][j], DP[i][j] + DS[i]);
            if (S[i] == ')') {
                DP[i+1][j+1] = min(DP[i+1][j+1], DP[i][j] + CS[i]);
                DP[i+1][j-1] = min(DP[i+1][j-1], DP[i][j]);
            } else {
                DP[i+1][j+1] = min(DP[i+1][j+1], DP[i][j]);
                DP[i+1][j-1] = min(DP[i+1][j-1], DP[i][j] + CS[i]);
            }
        }
    }
    writeln(DP[N][0]);
}