import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto x1 = xy[0];
    auto y1 = xy[1];
    auto x2 = xy[2];
    auto y2 = xy[3];

    int x3 = x2 + y1 - y2;
    int y3 = y2 - x1 + x2;
    int x4 = x3 + x1 - x2;
    int y4 = y3 + y1 - y2;

    writefln("%d %d %d %d", x3, y3, x4, y4);
}