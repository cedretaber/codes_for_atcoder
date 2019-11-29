import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto ab = readln.split.join("").to!int;
    writeln(ab == ab.to!float.sqrt.to!int^^2 ? "Yes" : "No");
}