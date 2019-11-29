import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abx = readln.split.to!(int[]);
    auto c = abx[2] - abx[0];
    writeln(c >= 0 && c <= abx[1] ? "YES" : "NO");   
}