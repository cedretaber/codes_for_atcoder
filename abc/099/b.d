import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto ab = readln.split.to!(int[]);
    int s, i = 1;
    while (i <= ab[1] - ab[0]) {
        s += i;
        ++i;
    }
    writeln(s - ab[1]);
}