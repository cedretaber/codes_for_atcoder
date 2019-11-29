import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto hb = readln.split.to!(double[]);
    auto h = hb[0]/100;
    auto bmi = hb[1];
    writefln("%.010f", bmi * h^^2);
}