import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ln = readln.split.to!(double[]);
    auto L = ln[0];
    auto X = ln[1];
    auto Y = ln[2];
    auto S = ln[3];
    auto D = ln[4];

    if (D > S) {
        auto a = (D-S) / (X+Y);
        if (Y-X <= 0) {
            writefln("%.010f", a);
            return;
        }
        writefln("%.010f", min(a, (L-D+S) / (Y-X)));
    } else {
        auto a = (L-S+D) / (X+Y);
        if (Y-X <= 0) {
            writefln("%.010f", a);
            return;
        }
        writefln("%.010f", min(a, (S-D) / (Y-X)));
    }
}