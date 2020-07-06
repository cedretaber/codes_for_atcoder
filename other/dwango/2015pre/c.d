import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;

    auto ps = new double[][][](N+1, N+1, N+1);
    ps[0][0][0] = 1;

    foreach (a; 0..N+1) foreach (b; 0..N+1) foreach (c; 0..N+1) {
        if (a == 0 && b == 0 && c == 0) continue;
        double r = 0;
        if (a) r += ps[a-1][b][c];
        if (b) r += ps[a][b-1][c];
        if (c) r += ps[a][b][c-1];
        ps[a][b][c] = r / 3.0;
    }

    auto DP = new double[](N+1);
    DP[0] = 0;
    DP[1] = 0;
    DP[2] = 1.5;

    foreach (n; 3..N+1) {
        double r = 0, d = 0;
        foreach (aa; 0..n+1) {
            foreach (bb; 0..n-aa+1) {
                auto a = aa;
                auto b = bb;
                auto c = n - a - b;
                if (a > b) swap(a, b);
                if (b > c) swap(b, c);
                if (a > b) swap(a, b);
                if (a == 0 && b == 0 || a == b && b == c) {
                    d += ps[a][b][c];
                } else {
                    auto x = a == 0 ? b : a;
                    r += ps[a][b][c] * DP[x];
                }
            }
        }
        DP[n] = (r + 1) / (1.0 - d);
    }

    writefln("%.12f", DP[N]);
}