import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto as = readln.split.to!(int[]);
    auto a1 = as[0];
    auto a2 = as[1];
    auto a3 = as[2];

    auto DP = new int[][][][](3,3,3,3);
    auto memo = new bool[][][][](3,3,3,3);

    int run(int i, int j, int k, int l) {
        if (i == 2 && j == a1-1 && k == a2-1 && l == a3-1) return 1;
        if (memo[i][j][k][l]) return DP[i][j][k][l];
        memo[i][j][k][l] = true;
        int r;
        if (i < 2) r += run(i+1, j, k, l);
        if (j < a1-1) r += run(i, j+1, k, l);
        if (i >= 1 && j >= k+1 && k < a2-1) r += run(i, j, k+1, l);
        if (i >= 2 && k >= l+1 && l < a3-1) r += run(i, k, k, l+1);
        return DP[i][j][k][l] = r;
    }
    writeln(run(0, 0, 0, 0));
}