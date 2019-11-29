import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nvl = readln.split.to!(int[]);
    auto N = nvl[0];
    double va = nvl[1];
    double vb = nvl[2];
    double L = nvl[3];

    foreach (_; 0..N) {
        auto t = L / va;
        L = t * vb;
    }
    writefln("%.10f", L);
}