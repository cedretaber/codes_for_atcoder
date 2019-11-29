import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto K = nk[1];
    auto rs = readln.split.to!(double[]);
    sort(rs);
    double x = 0;
    foreach (r; rs[$-K..$]) x = (x + r) / 2;
    writefln("%0.10f", x);
}