import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto H = readln.chomp.to!int;
    auto W = readln.chomp.to!int;
    auto N = readln.chomp.to!int;
    writeln((N + max(H, W) - 1) / max(H, W));
}