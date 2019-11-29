import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ab = readln.split.to!(long[]);
    writeln(ab[1] - ab[0] - (ab[0] < 0 && ab[1] > 0 ? 1 : 0));
}