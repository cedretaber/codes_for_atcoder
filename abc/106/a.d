import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    writeln(A * B - A - B + 1);
}