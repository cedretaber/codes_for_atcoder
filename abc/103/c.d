import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    writeln(as.sum - N);
}