import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    int X;
    foreach (c; N.to!(char[])) X += c-48;
    writeln(N.to!int % X == 0 ? "Yes" : "No");
}