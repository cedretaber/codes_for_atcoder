import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rr = readln.split.to!(double[]);
    auto r1 = rr[0];
    auto r2 = rr[1];
    writefln("%.010f", r1 * r2 / (r1 + r2));
}