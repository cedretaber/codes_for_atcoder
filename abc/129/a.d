import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto pqr = readln.split.to!(int[]);
    sort(pqr);
    writeln(pqr[0] + pqr[1]);
}