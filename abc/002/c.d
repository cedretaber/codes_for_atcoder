import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ps = readln.split.to!(double[]);
    auto a = ps[2] - ps[0];
    auto b = ps[3] - ps[1];
    auto c = ps[4] - ps[0];
    auto d = ps[5] - ps[1];
    writefln("%.03f", abs(a*d - b*c) / 2.0);
}