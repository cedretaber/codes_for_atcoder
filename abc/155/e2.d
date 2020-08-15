import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp;
    auto DP = new int[][](N.length+1, 2);
    DP[0][0] = 0;
    DP[0][1] = 1;
    foreach (i; 0..N.length) {
        auto n = (N[i] - '0').to!int;
        DP[i+1][0] = min(DP[i][0] + n, DP[i][1] + 10-n);
        DP[i+1][1] = min(n == 9 ? int.max : (DP[i][0] + n+1), DP[i][1] + 10-n-1);
    }
    writeln(DP[N.length][0]);
}