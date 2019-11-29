import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y", int, "h");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    ps.length = N;
    foreach (i; 0..N) {
        auto xyh = readln.split.to!(int[]);
        ps[i] = P(xyh[0], xyh[1], xyh[2]);
    }

    sort!"a.h > b.h"(ps);

    foreach (y; 0..101) {
        foreach (x; 0..101) {
            int h = -1;
            bool ok = true;
            foreach (p; ps) {
                auto ht = p.h + abs(x - p.x) + abs(y - p.y);
                if (h == -1) {
                    h = ht;
                } else if (p.h == 0) {
                    if (h > ht) {
                        ok = false;
                        break;
                    }
                } else {
                    if (h != ht) {
                        ok = false;
                        break;
                    }
                }
            }
            if (ok) {
                writefln("%d %d %d", x, y, h);
                return;
            }
        }
    }
}