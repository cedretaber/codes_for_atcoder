import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    readln;
    int[4] C;
    foreach (a; readln.chomp.to!(char[])) ++C[a-'1'];
    writefln("%d %d", max(C[0], C[1], C[2], C[3]), min(C[0], C[1], C[2], C[3]));
}