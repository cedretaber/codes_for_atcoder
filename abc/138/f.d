import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto lr = readln.split.to!(long[]);
    auto L = lr[0];
    auto R = lr[1];

    auto res = (R-L+1) % P;
}