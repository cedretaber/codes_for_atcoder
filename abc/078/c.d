import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto nm = readln.split.to!(int[]);
    writeln( (100 * (nm[0] - nm[1]) + 1900 * nm[1]) * (2^^nm[1]) );
}