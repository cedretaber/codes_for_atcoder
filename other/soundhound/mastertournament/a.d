import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto ab = readln.split.to!(int[]);
    writeln(ab[0] + ab[1] == 15 ? "+" : ab[0] * ab[1] == 15 ? "*" : "x");
}