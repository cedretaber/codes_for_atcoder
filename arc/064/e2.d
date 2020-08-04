import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "i", double, "c");

void main()
{
    auto xy = readln.split.to!(double[]);
    double[] xs, ys, rs;
    xs ~= xy[0];
    ys ~= xy[1];
    rs ~= 0;
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto xyr = readln.split.to!(double[]);
        xs ~= xyr[0];
        ys ~= xyr[1];
        rs ~= xyr[2];
    }
    xs ~= xy[2];
    ys ~= xy[3];
    rs ~= 0;

    auto G = new double[][](N+2, N+2);
    foreach (i; 0..N+2) {
        G[i][i] = 0;
        foreach (j; i+1..N+2) {
            G[i][j] = G[j][i] = max(0.0, sqrt((xs[i] - xs[j])^^2 + (ys[i] - ys[j])^^2) - rs[i] - rs[j]);
        }
    }

    auto DP = new double[](N+2);
    DP[] = 10L^^9*3;
    DP[0] = 0;
    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (j; 0..N+2) if (DP[j] > c + G[i][j]) {
            DP[j] = c + G[i][j];
            Q.insert(P(j, c + G[i][j]));
        }
    }
    writefln!"%.12f"(DP[N+1]);
}