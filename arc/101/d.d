import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    writeln(as[N/2]);
}