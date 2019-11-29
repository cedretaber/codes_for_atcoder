import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ds = readln.split.to!(int[]);
    sort(ds);
    writeln(ds[N/2] - ds[N/2-1]);
}