import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto xyz = readln.split.to!(int[]);
    int c;
    xyz[0] -= xyz[2];
    while (xyz[0] >= xyz[1] + xyz[2]) {
        xyz[0] -= (xyz[1] + xyz[2]);
        ++c;
    }
    writeln(c);
}