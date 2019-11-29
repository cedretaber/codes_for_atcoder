import std.stdio, std.string, std.array, std.conv, std.algorithm;

void main()
{
    auto n = readln.chomp.to!int;
    writeln(n * 800 - 200 * (n/15));
}