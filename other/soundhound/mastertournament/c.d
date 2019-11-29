import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto nmd = readln.split.to!(long[]);
    auto n = nmd[0];
    auto m = nmd[1];
    auto d = nmd[2];

    writefln("%0.10f", (n - d) * 2 * (m - 1) / (n ^^ 2).to!double / (d == 0 ? 2 : 1));
}