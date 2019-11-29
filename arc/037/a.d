import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    readln;
    int s;
    foreach (m; readln.split.to!(int[])) {
        if (m < 80) s += 80 - m;
    }
    writeln(s);
}