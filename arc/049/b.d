import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias TN = Tuple!(double, "x", double, "y", double, "c");

TN[1000] TS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xyc = readln.split.to!(double[]);
        TS[i] = TN(xyc[0], xyc[1], xyc[2]);
    }
    double t_min = 0, t_max = 10e9;
    foreach (_; 0..1000) {
        auto t = (t_min + t_max) / 2;
        double lx = -1e5, ly = -1e5, rx = 1e5, ry = 1e5;
        foreach (n; TS[0..N]) {
            lx = max(lx, n.x-t/n.c);
            ly = max(ly, n.y-t/n.c);
            rx = min(rx, n.x+t/n.c);
            ry = min(ry, n.y+t/n.c);
        }
        if (lx < rx && ly < ry) {
            t_max = t;
        } else {
            t_min = t;
        }
    }
    writefln("%.010f", t_max);
}