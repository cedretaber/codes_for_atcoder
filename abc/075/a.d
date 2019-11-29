import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto abc = readln.split.to!(int[]);
    writeln(abc[0] == abc[1] ? abc[2] : abc[0] == abc[2] ? abc[1] : abc[0]);
}