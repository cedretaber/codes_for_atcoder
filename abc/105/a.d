import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto nk = readln.split.to!(int[]);
    writeln(nk[0] % nk[1] ? 1 : 0);
}