import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;
    int r;
    foreach (i, s; S) {
        if (s != T[i]) ++r;
    }
    writeln(r);
}