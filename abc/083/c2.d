import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto a = X;
    long r;
    while (a <= Y) {
        ++r;
        a *= 2;
    }
    writeln(r);
}