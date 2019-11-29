import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    writeln(N/2 - (N%2 == 0 ? 1 : 0));
}