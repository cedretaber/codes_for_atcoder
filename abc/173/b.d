import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum RS = ["AC", "WA", "TLE", "RE"];

void main()
{
    auto N = readln.chomp.to!int;
    int[string] rs;
    foreach (r; RS) rs[r] = 0;
    foreach (_; 0..N) {
        auto r = readln.chomp;
        rs[r] += 1;
    }
    foreach (r; RS) {
        writefln("%s x %d", r, rs[r]);
    }
}