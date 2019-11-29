import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Point = Tuple!(long, "x", long, "y");

Point[50] PS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        PS[i] = Point(xy[0], xy[1]);
    }

    auto ps = PS[0..N];

    auto min_size = long.max;
    foreach (a; ps) {
        foreach (b; ps) {
            foreach (c; ps) {
                foreach (d; ps) {
                    auto max_x = max(a.x, b.x, c.x, d.x);
                    auto min_x = min(a.x, b.x, c.x, d.x);
                    auto max_y = max(a.y, b.y, c.y, d.y);
                    auto min_y = min(a.y, b.y, c.y, d.y);

                    int cnt;
                    foreach (p; ps) if (min_x <= p.x && p.x <= max_x && min_y <= p.y && p.y <= max_y) ++cnt;
                    if (cnt >= K) min_size = min(min_size, (max_x - min_x) * (max_y - min_y));
                }
            }
        }
    }
    writeln(min_size);
}