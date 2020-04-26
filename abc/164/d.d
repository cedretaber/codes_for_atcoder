import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto DP = new long[][](2, 2019);
    long r;
    foreach (i, c; S) {
        auto n = c - '0';
        foreach (x; 0..2019) DP[i%2][x] = 0;
        DP[i%2][n] = 1;
        foreach (x; 0..2019) DP[i%2][(x * 10 + n) % 2019] += DP[(i+1)%2][x];
        r += DP[i%2][0];
    }
    writeln(r);
}