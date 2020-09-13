import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto abcd = readln.split.to!(long[]);
    auto a = abcd[0];
    auto b = abcd[1];
    auto c = abcd[2];
    auto d = abcd[3];
    writeln(max(a*c, a*d, b*c, b*d));
}