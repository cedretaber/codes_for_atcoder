import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias P = Tuple!(double, "x", double, "y");
P[100] PS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        PS[i] = P(xy[0], xy[1]);
    }
    double r = 0;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            r = max(r, sqrt((PS[i].x - PS[j].x)^^2 + (PS[i].y - PS[j].y)^^2));
        }
    }
    writefln("%.10f", r);
}