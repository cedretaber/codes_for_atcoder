import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    long r;
    foreach (a; readln.split.to!(long[])) r += a-1;
    writeln(r);
}