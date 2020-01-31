import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    writeln(ab[0]%2 == 1 && ab[1]%2 == 1 ? "Odd" : "Even");
}