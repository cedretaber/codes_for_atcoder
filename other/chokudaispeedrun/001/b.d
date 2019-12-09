import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    writeln(reduce!"a + b"(0, readln.split.to!(int[])));
}