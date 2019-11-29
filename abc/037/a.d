import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(int[]);
    writeln(abc[2] / min(abc[0], abc[1]));
}