import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(double, "x", double, "y");

double longest_distance(P[] ps)
{
    double x = 0, y = 0;
    foreach (p; ps) {
        x += p.x;
        y += p.y;
    }
    x /= ps.length;
    y /= ps.length;
    double d = 0;
    foreach (p; ps) {
        auto dd = sqrt((x - p.x)^^2 + (y - p.y)^^2);
        d = max(d, dd);
    }
    return d;
}

void main()
{
    auto N = readln.chomp.to!int;
    P[] as, bs;
    foreach (i; 0..N*2) {
        auto xy = readln.split.to!(double[]);
        auto p = P(xy[0], xy[1]);
        if (i < N) {
            as ~= p;
        } else {
            bs ~= p;
        }
    }
    writefln!"%.12f"(longest_distance(bs) / longest_distance(as));
}