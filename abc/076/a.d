import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto R = readln.chomp.to!int;
    auto G = readln.chomp.to!int;
    writeln(2 * G - R);
}