import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto ni = readln.split.to!(int[]);
    writeln(ni[0] - ni[1] + 1);
}