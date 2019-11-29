import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    writeln(max(ab[0] + ab[1], ab[0] - ab[1], ab[0] * ab[1]));
}