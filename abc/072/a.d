import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    long x, t;
    readf("%d %d", &x, &t);
    writeln(x < t ? 0 : x - t);
}