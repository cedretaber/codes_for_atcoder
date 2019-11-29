import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto X = readln.chomp.to!int;
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;

    writeln((X - A) % B);
}