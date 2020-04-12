import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    auto DP = new long[][](N+5, 3);
    foreach (ref dp; DP) dp[] = long.min/3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        foreach (j; 0..3) {
            DP[i+2][j] = max(DP[i+2][j], DP[i][j] + AS[i]);
            if (j < 2) DP[i+1][j+1] = max(DP[i+1][j+1], DP[i][j]);
        }
    }
    if (N%2 == 0) {
        writeln(max(DP[N-2][0] + AS[N-2], DP[N-1][1] + AS[N-1]));
    } else {
        writeln(max(DP[N-1][2] + AS[N-1], DP[N-2][1] + AS[N-2], DP[N-3][0] + AS[N-3]));
    }
}