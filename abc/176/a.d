import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nxt = readln.split.to!(int[]);
    auto N = nxt[0];
    auto X = nxt[1];
    auto T = nxt[2];
    writeln((N + X - 1) / X * T);
}