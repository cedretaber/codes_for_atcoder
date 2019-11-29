import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(int[]);
    auto AB = abc[0];
    auto BC = abc[1];
    writeln(AB * BC / 2);
}