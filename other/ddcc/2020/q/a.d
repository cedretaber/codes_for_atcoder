import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum PS = [300000, 200000, 100000];

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];
    int r;
    if (X <= 3) r += PS[X-1];
    if (Y <= 3) r += PS[Y-1];
    if (X == 1 && Y == 1) r += 400000;
    writeln(r);
}