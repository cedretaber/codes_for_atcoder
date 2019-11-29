import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto whxy = readln.split.to!(double[]);
    auto W = whxy[0];
    auto H = whxy[1];
    auto X = whxy[2];
    auto Y = whxy[3];

    writefln("%.012f %d", W*H/2, W/2 == X && H/2 == Y ? 1 : 0);
}