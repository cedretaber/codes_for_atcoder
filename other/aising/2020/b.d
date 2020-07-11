import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int c;
    foreach (i, a; readln.split.to!(int[])) if (i%2 == 0 && a%2 == 1) ++c;
    writeln(c);
}