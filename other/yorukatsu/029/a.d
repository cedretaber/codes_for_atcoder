import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    int r = 1, d;
    foreach (l; readln.split.to!(int[])) {
        d += l;
        if (d > X) break;
        ++r;
    }
    writeln(r);
}