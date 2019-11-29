import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = abs(ab[0]);
    auto B = abs(ab[1]);
    writeln(A < B ? "Ant" : A > B ? "Bug" : "Draw");
}