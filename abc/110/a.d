import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(int[]);
    auto d = abc[0] + abc[1] + abc[2];
    writeln(d + max(abc[0], abc[1], abc[2]) * 9);
}