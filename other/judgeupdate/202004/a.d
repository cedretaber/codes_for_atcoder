import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto slr = readln.split.to!(int[]);
    auto S = slr[0];
    auto L = slr[1];
    auto R = slr[2];
    writeln(S <= L ? L : S >= R ? R : S);
}