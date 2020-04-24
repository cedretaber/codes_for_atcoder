import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto n = max(A + B, A * B);
    writeln(max(n + C, n * C));
}