import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    auto ps = readln.split.to!(int[]);
    int r;
    foreach (s; readln.split.to!(int[])) r += ps[s-1];
    writeln(r);
}