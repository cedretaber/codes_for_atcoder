import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

long solve(long x)
{
    if (x == 0) return 0;
    auto xx = x;
    int[] nn;
    while (xx) {
        nn ~= (xx%10).to!int;
        xx /= 10;
    }
    nn.reverse();
    auto N = nn.length;

    auto DP = new long[][](N+1, 2);
    DP[0][1] = 1;
    foreach (i; 0..N) {
        DP[i+1][0] += DP[i][0] * 8;
        DP[i+1][0] += DP[i][1] * (nn[i] - (nn[i] > 4 ? 1 : 0));
        if (nn[i] != 4 && nn[i] != 9) DP[i+1][1] = DP[i][1];
    }
    return x - (DP[N][0] + DP[N][1]) + 1; // The result includes zero, but x does not contain it.
}

void main()
{
    auto ab = readln.split.to!(long[]);
    writeln(solve(ab[1]) - solve(ab[0]-1));
}