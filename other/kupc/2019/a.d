import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    auto as = readln.split.to!(int[]);
    auto max_a = reduce!"a > b ? a : b"(0, as);
    int r;
    foreach (a; as) if (a + X >= max_a) ++r;
    writeln(r);
}