import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!long;
    auto B = readln.chomp.to!long;
    auto C = readln.chomp.to!long;
    auto D = readln.chomp.to!long;
    auto P = readln.chomp.to!long;
    writeln(min(A * P, B + max(0, P - C) * D));
}