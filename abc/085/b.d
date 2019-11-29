import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;


void main()
{
    auto n = readln.chomp.to!int;
    int[] ms;
    ms.length = n;
    foreach (i; 0..n)
        ms[i] = readln.chomp.to!int;
    ms.sort;
    ms = ms.uniq.array;
    writeln(ms.length);
}