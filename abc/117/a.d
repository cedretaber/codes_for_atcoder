import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto tx = readln.split.to!(double[]);
    auto T = tx[0];
    auto X = tx[1];
    writefln("%.10f", T / X);
}