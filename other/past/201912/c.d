import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto af = readln.split.to!(int[]);
    sort!"a > b"(af);
    writeln(af[2]);
}