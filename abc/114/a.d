import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;
    writeln(X == 7 || X == 5 || X == 3 ? "YES" : "NO");
}