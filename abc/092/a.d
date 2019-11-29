import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto D = readln.chomp.to!int;
    writeln(min(A, B) + min(C, D));
}