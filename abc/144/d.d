import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abx = readln.split.to!(real[]);
    auto a = abx[0];
    auto b = abx[1];
    auto x = abx[2];

    real min_r = 0, max_r = 90;
    foreach (_; 0..10000) {
        auto r = (min_r + max_r) / 2;
        auto t = r * (PI / 180);
        real y;
        if (sin(t)*b > cos(t)*a) {
            y = (a*b - a*a/(2*tan(t))) * a;
        } else {
            y = (tan(t)*b*b/2) * a;
        }
        if (x <= y) {
            max_r = r;
        } else {
            min_r = r;
        }
    }
    writefln("%2.10f", 90 - max_r);
}