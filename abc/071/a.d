import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto xab = readln.split.to!(int[]);
    writeln(abs(xab[0] - xab[1]) > abs(xab[0] - xab[2]) ? "B" : "A");
}