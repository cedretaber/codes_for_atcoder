import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto ab = readln.split.to!(int[]);
    writeln(ab[0] & 1 && ab[1] & 1 ? "Yes" : "No");
}