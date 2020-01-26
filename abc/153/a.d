import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ha = readln.split.to!(int[]);
    auto H = ha[0];
    auto A = ha[1];
    writeln((H+A-1)/A);
}