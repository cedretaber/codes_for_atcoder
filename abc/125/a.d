import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abt = readln.split.to!(int[]);
    auto A = abt[0];
    auto B = abt[1];
    auto T = abt[2];
    writeln(B * (T / A));
}