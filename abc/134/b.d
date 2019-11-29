import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];
    auto d = D*2+1;
    writeln((N+d-1) / d);
}