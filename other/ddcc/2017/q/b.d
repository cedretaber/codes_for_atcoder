import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto i = readln.split.to!(int[]);
    writeln(i[0]*12^^3 + i[1]*12^^2 + i[2]*12 + i[3]);
}