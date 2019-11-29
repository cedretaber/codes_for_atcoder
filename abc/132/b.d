import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);
    int c;
    foreach (i; 1..N-1) {
        auto x = ps[i-1];
        auto y = ps[i];
        auto z = ps[i+1];
        if (x < y && y < z || z < y && y < x) ++c;
    }
    writeln(c);
}