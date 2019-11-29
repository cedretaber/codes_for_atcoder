import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = readln.split.to!(int[]);
    auto as = readln.split.to!(int[]);
    int max_p;
    foreach (i; 0..N) max_p = max(max_p, ss[i] * as[i]);
    writeln(max_p);
}