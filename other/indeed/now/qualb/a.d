import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy1 = readln.split.to!(int[]);
    auto xy2 = readln.split.to!(int[]);
    writeln(abs(xy1[0] - xy2[0]) + abs(xy1[1] - xy2[1]) + 1);
}