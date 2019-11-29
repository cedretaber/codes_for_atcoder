import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    writeln(readln.split.join.to!int % 4 == 0 ? "YES" : "NO");
}