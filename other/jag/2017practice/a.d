import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nhw = readln.split.to!(int[]);
    auto N = nhw[0];
    auto H = nhw[1];
    auto W = nhw[2];

    auto P = new int[](N*W);
    foreach (ii, x; readln.split.to!(int[])) {
        auto i = ii.to!int;
        if (i%2 == 0) {
            ++P[min(W*i+x, N*W-W)];
            if (W*i+x+W < N*W) --P[W*i+x+W];
        } else {
            ++P[max(0, W*i-x)];
            if (W*i-x < 0) {
                --P[0];
            } else if (W*i-x+W < N*W) {
                --P[W*i-x+W];
            }
        }
    }
    int x, r;
    foreach (p; P) {
        x += p;
        if (x == 0) ++r;
    }
    writeln(r * H);
}