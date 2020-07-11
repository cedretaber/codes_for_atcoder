import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto lrd = readln.split.to!(int[]);
    auto L = lrd[0];
    auto R = lrd[1];
    auto d = lrd[2];
    int c;
    foreach (i; L..R+1) if (i%d == 0) ++c;
    writeln(c);
}