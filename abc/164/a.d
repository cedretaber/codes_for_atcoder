import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto sw = readln.split.to!(int[]);
    writeln(sw[1] >= sw[0] ? "unsafe" : "safe");
}