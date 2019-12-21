import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto D = readln.chomp.to!int;
    auto E = readln.chomp.to!int;

    writeln((A < 0 ? abs(A) * C + D : 0) + (B - max(A, 0)) * E);
}