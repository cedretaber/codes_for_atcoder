import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto md1 = readln.split.to!(int[]);
    auto md2 = readln.split.to!(int[]);
    writeln(md1[0] == md2[0] ? 0 : 1);
}