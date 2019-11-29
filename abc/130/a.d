import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xa = readln.split.to!(int[]);
    writeln(xa[0] < xa[1] ? 0 : 10);
}