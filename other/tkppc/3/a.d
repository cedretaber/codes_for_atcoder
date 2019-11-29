import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln.split;
    auto b = readln.split;
    auto ab = [a[1].to!int * (a[0] == "E" ? 1 : -1), b[1].to!int * (b[0] == "E" ? 1 : -1)];
    sort(ab);
    writeln((ab[1] - ab[0]) / 15);
}