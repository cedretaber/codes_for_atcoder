import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    foreach (i, x; readln.split.to!(int[])) if (x == 0) {
        writeln(i+1);
        return;
    }
}