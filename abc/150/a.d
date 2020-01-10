import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kx = readln.split.to!(int[]);
    auto K = kx[0];
    auto X = kx[1];
    writeln(500*K >= X ? "Yes" : "No");
}