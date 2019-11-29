import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto n = readln.chomp.to!int;
    auto k = readln.chomp.to!int;

    writeln(n >= k*2 ? "YES" : "NO");
}