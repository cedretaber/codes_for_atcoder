import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    int i;
    foreach (a; readln.split.to!(int[])) {
        ++i;
        if (a == 1) {
            writeln(i);
            return;
        }
    }
}