import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ap = readln.split.to!(int[]);
    auto A = ap[0];
    auto P = ap[1];
    writeln((P + A*3)/2);   
}