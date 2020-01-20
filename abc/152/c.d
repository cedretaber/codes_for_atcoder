import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);
    int r, min_p = ps[0];
    foreach (p; ps) {
        min_p = min(min_p, p);
        if (p == min_p) ++r;
    }
    writeln(r);
}