import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias XY = Tuple!(long, "x", long, "y");

XY[1000] XYS;

void main()
{
    auto N = readln.chomp.to!int;
    long c = -1;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        auto x = xy[0];
        auto y = xy[1];
        XYS[i] = XY(x, y);
        if (c < 0) c = abs((x + y) % 2);
        if (c != abs((x + y) % 2)) {
            writeln("-1");
            return;
        }
    }

    long[] ds;
    ds.length = 39;
    foreach (i; 0..39) {
        ds[i] = 1L<<i;
    }
    if (!c) ds = [1L] ~ ds;
    writeln(ds.length);
    writeln(ds.map!(to!string).join(" "));

    foreach (xy; XYS[0..N]) {
        auto u = -xy.x - xy.y;
        auto v = -xy.x + xy.y;
        string r;
        foreach_reverse (d; ds) {
            auto a = u < 0 ? 1 : -1;
            auto b = v < 0 ? 1 : -1;
            u += a * d;
            v += b * d;
            if (a == 1 && b == 1) {
                r = "R" ~ r;
            } else if (a == 1 && b == -1) {
                r = "U" ~ r;
            } else if (a == -1 && b == 1) {
                r = "D" ~ r;
            } else {
                r = "L" ~ r;
            }
        }
        writeln(r);
    }
}