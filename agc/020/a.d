import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto A = nab[1];
    auto B = nab[2];
    writeln(A%2 == B%2 ? "Alice" : "Borys");
}