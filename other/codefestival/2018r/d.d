import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum GR = (1.0 + sqrt(5.0)) / 2.0;

alias P = Tuple!(real, "x", real, "w");

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = new P[](N);
    foreach (i; 0..N) {
        auto xw = readln.split.to!(real[]);
        ps[i] = P(xw[0], xw[1]);
    }
    auto x = ps[0].x, y = ps[$-1].x;
    foreach (_; 0..100) {
        auto l = x + (y-x)/(GR+1);
        auto r = x + (y-x)/GR;
        real lw = -10.0^^13, rw = -10.0^^13;
        foreach (i; 0..N) {
            lw = max(lw, abs(ps[i].x - l) * ps[i].w);
            rw = max(rw, abs(ps[i].x - r) * ps[i].w);
        }
        if (lw < rw) {
            y = r;
        } else {
            x = l;
        }
    }
    writefln("%.12f", (x+y)/2);
}