import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto a = readln.chomp.to!int;
    writeln(a + a^^2 + a^^3);
}