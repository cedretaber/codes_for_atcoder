import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nm = readln.split.to!(int[]);
    writeln(nm[1] == 1 ? "2" : "1");
}