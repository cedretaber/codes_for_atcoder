import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    long D = nd[1];
    int c;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(long[]);
        if (xy[0]^^2 + xy[1]^^2 <= D^^2) ++c;
    }
    writeln(c);
}