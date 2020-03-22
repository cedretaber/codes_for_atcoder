import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto L = readln.chomp.to!double;
    writefln("%.10f", (L/3.0)^^3);
}