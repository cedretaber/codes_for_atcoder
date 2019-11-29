import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    writeln(N%4 == 0 && (N%100 != 0 || N%400 == 0) ? "YES" : "NO");
}