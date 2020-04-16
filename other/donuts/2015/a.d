import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rd = readln.split.to!(double[]);
    auto R = rd[0];
    auto D = rd[1];
    writefln("%.12f", R*R*PI*D*2*PI);
}