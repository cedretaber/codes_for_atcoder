import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto x = xy[0];
    auto y = xy[1];
    auto k = readln.chomp.to!int;

    writeln(k <= y ? x + k : y*2 + x - k);
}