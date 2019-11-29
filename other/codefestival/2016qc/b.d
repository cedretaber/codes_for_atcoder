import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kt = readln.split.to!(int[]);
    auto K = kt[0];
    auto as = readln.split.to!(int[]);
    sort!"a > b"(as);
    writeln(max(0, as[0]*2 - K - 1));
}