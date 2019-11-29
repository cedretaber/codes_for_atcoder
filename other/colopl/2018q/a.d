import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto S = readln.chomp;
    writeln(ab[0] <= S.length && S.length <= ab[1] ? "YES" : "NO");
}