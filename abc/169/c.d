import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(real[]);
    auto A = ab[0];
    auto B = ab[1];
    writeln((A * B).to!long);
}