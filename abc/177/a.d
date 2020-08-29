import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto dts = readln.split.to!(int[]);
    auto D = dts[0];
    auto T = dts[1];
    auto S = dts[2];
    writeln(D <= T * S ? "Yes" : "No");
}