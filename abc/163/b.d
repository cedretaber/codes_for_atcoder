import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int as;
    foreach (a; readln.split.to!(int[])) as += a;
    writeln(max(-1, N - as));
}