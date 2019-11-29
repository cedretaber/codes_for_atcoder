import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto lx = readln.split.to!(int[]);
    auto L = lx[0];
    auto X = lx[1];
    auto d = X % (L*2);
    writeln(d <= L ? d : L*2 - d);
}