import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint, std.complex;

void main()
{
    auto xy = readln.split.to!(double[]);
    auto x = xy[0];
    auto y = xy[1];

    double x1, x2, y1, y2;
    double solve()
    {
        auto a = x2 - x1;
        auto b = y2 - y1;
        auto r2 = a^^2 + b^^2;
        auto tt = -(a*(x1 - x) + b*(y1 - y));
        double rr;
        if (tt < 0) {
            rr = (x1-x)^^2 + (y1-y)^^2;
        } else if (tt > r2) {
            rr = (x2-x)^^2 + (y2-y)^^2;
        } else {
            auto f = a*(y1-y) - b*(x1-x);
            rr = f^^2/r2;
        }
        return sqrt(rr);
    }

    auto N = readln.chomp.to!int;

    xy = readln.split.to!(double[]);
    auto x0 = xy[0];
    auto y0 = xy[1];
    x1 = x0; y1 = y0;
    double r = 300;

    foreach (_; 0..N-1) {
        xy = readln.split.to!(double[]);
        x2 = xy[0];
        y2 = xy[1];
        r = min(r, solve());
        x1 = x2; y1 = y2;
    }
    x2 = x0; y2 = y0;
    writefln("%.010f", min(r, solve()));
}