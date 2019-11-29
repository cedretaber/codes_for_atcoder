import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];

    writeln(X + Y / 2);
}