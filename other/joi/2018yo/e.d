import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias S = Tuple!(int, "x", int, "y", int, "d", int, "t");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] AS;
    foreach (_; 0..H) AS ~= readln.split.to!(int[]);

    auto DP = new int[][][](H, W, H*W);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max;
    DP[0][0][0] = 0;

    auto Q = heapify!"a.t > b.t"([S(0, 0, 0, 0)]);
    while (!Q.empty) {
        with (Q.front) {
            Q.removeFront();
            static foreach (dd; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto xx = x+dd[0];
                auto yy = y+dd[1];
                if (0 <= xx && xx < W && 0 <= yy && yy < H) {
                    auto tt = t + d * 2 * AS[yy][xx] + AS[yy][xx];
                    if (d < H*W && DP[yy][xx][d] > tt) {
                        DP[yy][xx][d] = tt;
                        Q.insert(S(xx, yy, d+1, tt));
                    }
                }
            }}
        }
    }
    writeln(DP[H-1][W-1].minElement);
}