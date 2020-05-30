import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hmk = readln.split.to!(int[]);
    auto h1 = hmk[0];
    auto m1 = hmk[1];
    auto h2 = hmk[2];
    auto m2 = hmk[3];
    auto K = hmk[4];

    auto s = h1 * 60 + m1;
    auto e = h2 * 60 + m2;
    auto r = e - K - s;
    writeln(r);
}