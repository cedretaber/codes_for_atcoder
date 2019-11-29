import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias P = Tuple!(long, "x", long, "y");
P[10^^5] PS;

void main()
{
    auto N = readln.chomp.to!int;
    long x_max = long.min, x_min = long.max, y_max = long.min, y_min = long.max;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        auto x = xy[0] + xy[1];
        auto y = xy[0] - xy[1];
        x_max = max(x_max, x);
        x_min = min(x_min, x);
        y_max = max(y_max, y);
        y_min = min(y_min, y);
        PS[i] = P(xy[0], xy[1]);
    }
    auto d = max(x_max - x_min, y_max - y_min);
    foreach (long x; [x_min + d/2, x_max - d/2]) {
        foreach (long y; [y_min + d/2, y_max - d/2]) {
            auto ox = (x+y)/2;
            auto oy = (x-y)/2;
            if (ox < -10^^9 || ox > 10^^9 || oy < -10^^9 || oy > 10^^9) continue;
            auto dd = abs(PS[0].x - ox) + abs(PS[0].y - oy);
            foreach (p; PS[1..N]) {
                if (dd != abs(p.x - ox) + abs(p.y - oy)) goto next;
            }
            writefln("%d %d", ox, oy);
            return;
            next:
        }
    }
}