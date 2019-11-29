import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];

    writeln(abs(X - Y) <= 1 ? "Brown" : "Alice");
}