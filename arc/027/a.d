import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto hm = readln.split.to!(int[]);
    writeln(18*60 - hm[0]*60 - hm[1]);
}