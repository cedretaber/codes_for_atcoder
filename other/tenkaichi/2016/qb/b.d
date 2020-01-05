import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto len = S.length;

    auto DP = new int[][][](len, len, len);
    int solve(int i, int j, int s) {
        if (i == len) return s == 0 ? 0 : int.max/3;
        if (DP[i][j][s] == 0) {
            auto t = S[i] == '(' ? 1 : -1;
            auto r1 = s+t < 0 ? int.max/3 : solve(i+1, j, s + t);
            auto r2 = s-t < 0 ? int.max/3 : solve(i+1, i, s - t) + i-j+1;
            DP[i][j][s] = min(r1, r2);
        }
        return DP[i][j][s];
    }
    writeln(solve(0, 0, 0));
}