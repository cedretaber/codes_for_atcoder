import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    int max_a = int.min, r;
    foreach (a; readln.split.to!(int[])) {
        if (a > max_a) ++r;
        max_a = max(max_a, a);
    }
    writeln(r);
}