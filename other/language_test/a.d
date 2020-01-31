import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln.chomp.to!int;
    auto bc = readln.split.to!(int[]);
    auto s = readln.chomp;
    writefln("%d %s", a + bc[0] + bc[1], s);
}