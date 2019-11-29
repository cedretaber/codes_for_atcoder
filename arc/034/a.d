import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    double r = 0;
    foreach (_; 0..N) {
        auto a = readln.split.to!(double[]);
        r = max(r, a[0] + a[1] + a[2] + a[3] + a[4] * 110 / 900);
    }
    writefln("%.010f", r);
}