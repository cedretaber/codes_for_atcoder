import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto n = readln.chomp.to!double;
    writefln("%.10f", n*9/5.0+32);
}