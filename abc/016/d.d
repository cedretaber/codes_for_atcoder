import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Point = Tuple!(double, "x", double, "y");

bool intersection(Point a, Point b, Point c, Point d)
{
    auto tc = (a.x - b.x) * (c.y - a.y) + (a.y - b.y) * (a.x - c.x);
    auto td = (a.x - b.x) * (d.y - a.y) + (a.y - b.y) * (a.x - d.x);
    auto ta = (c.x - d.x) * (a.y - c.y) + (c.y - d.y) * (c.x - a.x);
    auto tb = (c.x - d.x) * (b.y - c.y) + (c.y - d.y) * (c.x - b.x);

    return tc * td < 0 && ta * tb < 0;
}

Point[100] PS;

void main()
{
    auto ab = readln.split.to!(double[]);
    auto A = Point(ab[0], ab[1]);
    auto B = Point(ab[2], ab[3]);
    auto N = readln.chomp.to!int;

    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        PS[i] = Point(xy[0], xy[1]);
    }

    int x;
    foreach (i; 0..N-1) {
        if (intersection(A, B, PS[i], PS[i+1])) ++x;
    }
    if (intersection(A, B, PS[N-1], PS[0])) ++x;
    
    writeln(x/2+1);
}