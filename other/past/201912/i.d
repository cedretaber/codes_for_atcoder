import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto SS = new uint[](M);
    auto CS = new long[](M);
    foreach (i; 0..M) {
        auto sc = readln.split;
        CS[i] = sc[1].to!long;
        uint s;
        foreach (j, c; sc[0]) if (c == 'Y') s |= 1<<j;
        SS[i] = s;
    }

    auto DP = new long[][](M, 1<<N);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, uint s) {
        if (i == M) return s == ((1<<N)-1) ? 0 : long.max/3;
        if (DP[i][s] == -1) DP[i][s] = min(solve(i+1, s), solve(i+1, s | SS[i]) + CS[i]);
        return DP[i][s];
    }
    auto r = solve(0, 0);
    writeln(r >= long.max/3 ? -1 : r);
}