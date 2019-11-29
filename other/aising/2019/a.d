import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto H = readln.chomp.to!int;
    auto W = readln.chomp.to!int;

    writeln((N - W + 1) * (N - H + 1));
}