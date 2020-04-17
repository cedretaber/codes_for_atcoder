import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;
    auto x = readln.chomp.to!int;
    writeln(x * 540 + (n-x) * 525);
}