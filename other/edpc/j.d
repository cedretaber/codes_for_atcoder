import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    double[][][] DP;

    DP.length = 301;
    foreach (ref dp1; DP) {
        dp1.length = 301;
        foreach (ref dp2; dp1) dp2.length = 301;
    }

    auto N = readln.chomp.to!int;

    auto n = N.to!double;
    double solve(int a, int b, int c) {
        if (!a && !b && !c) return 0;
        if (!isNaN(DP[a][b][c])) return DP[a][b][c];

        double r = 0;
        if (a) r += solve(a-1, b+1, c) * a;
        if (b) r += solve(a, b-1, c+1) * b;
        if (c) r += solve(a, b, c-1) * c;
        return DP[a][b][c] = (r + n) / (a + b + c);
    }

    int three, two, one;
    foreach (a; readln.split.to!(int[])) {
        switch (a) {
            case 1:
                ++one;
                break;
            case 2:
                ++two;
                break;
            case 3:
                ++three;
                break;
            default:
        }
    }

    writefln("%.12f", solve(three, two, one));
}