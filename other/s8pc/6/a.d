import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto T = nt[1];
    auto as = reduce!"a + b"(0, readln.split.to!(int[]));
    writeln((as + T - 1) / T);
}