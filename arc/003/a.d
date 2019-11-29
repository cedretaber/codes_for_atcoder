import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum atoi = [
    'A': 4,
    'B': 3,
    'C': 2,
    'D': 1,
    'F': 0
];

void main()
{
    auto N = readln.chomp.to!double;
    double p = 0;
    foreach (c; readln.chomp.to!(char[])) p += atoi[c];
    writefln("%.10f", p / N);
}