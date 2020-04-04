import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xyz = readln.split.to!(int[]);
    writeln(xyz[2], " ", xyz[0], " ", xyz[1]);
}