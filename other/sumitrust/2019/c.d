import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;
    auto DP = new int[][](6, 10^^5+1);
    int solve(int i, int x) {
        if (i == 6) return x == 0 ? 1 : -1;
        if (DP[i][x] != 0) return DP[i][x];
        int r = solve(i+1, x);
        if (x >= 100 + i) r = max(r, solve(i, x - (100+i)));
        DP[i][x] = r;
        return DP[i][x];
    }

    writeln(solve(0, X) == 1 ? 1 : 0);
}