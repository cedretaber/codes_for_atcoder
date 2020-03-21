import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
 
void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] ss;
    foreach (_; 0..H) ss ~= readln.chomp.to!(char[]);
 
    auto DP = new int[][][](2, H, W);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    int solve(int c, int i, int j) {
        auto x = c == 0 && ss[i][j] == '#' ? 1 : 0;
        if (i == H-1 && j == W-1) return x;
        if (DP[c][i][j] == -1) {
            auto cc = ss[i][j] == '.' ? 0 : 1;
            DP[c][i][j] = min(
                i == H-1 ? 10001 : solve(cc, i+1, j) + x,
                j == W-1 ? 10001 : solve(cc, i, j+1) + x
            );
        }
        return DP[c][i][j];
    }
    writeln(solve(0, 0, 0));
}