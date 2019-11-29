import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum CF = "CODEFESTIVAL2016";

void main()
{
    auto S = readln.chomp;
    int r;
    foreach (i, c; S) if (c != CF[i]) ++r;
    writeln(r);
}