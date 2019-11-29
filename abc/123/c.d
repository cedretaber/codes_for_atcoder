import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    auto A = readln.chomp.to!long;
    auto B = readln.chomp.to!long;
    auto C = readln.chomp.to!long;
    auto D = readln.chomp.to!long;
    auto E = readln.chomp.to!long;

    auto x = min(A, B, C, D, E);
    writeln(4 + (N+x-1)/x);
}