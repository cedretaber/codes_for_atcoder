import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = 0.reduce!"a + b"(readln.split.to!(int[]));
    auto T = 0.reduce!"a + b"(readln.split.to!(int[]));
    writeln(max(S, T));
}