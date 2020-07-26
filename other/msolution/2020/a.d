import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto X = readln.chomp.to!int;
    writeln(8 - (X-400)/200);
}