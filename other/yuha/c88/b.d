import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    writeln(readln.chomp.to!int%4 == 0 ? "GO" : "SEN");
}