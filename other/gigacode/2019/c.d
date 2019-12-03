import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto D = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);
    long s, min_p = long.max;
    foreach (i; 0..D) {
        s += as[i];
        if (bs[i] <= s) min_p = min(min_p, bs[i]);
    }
    writeln(min_p == long.max ? -1 : min_p);
}