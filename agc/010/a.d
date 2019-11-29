import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    int c;
    foreach (i; readln.split.to!(int[])) if (i%2 == 1) ++c;
    writeln(c%2 == 0 ? "YES" : "NO");
}