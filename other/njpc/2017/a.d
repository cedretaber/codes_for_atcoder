import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto L = readln.chomp.to!int;
    auto S = readln.chomp;
    writeln(S[0..min($, L)]);
}