import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.split[1].to!int;
    auto ps = readln.split.to!(int[]);
    sort(ps);
    int r;
    foreach (i; 0..K) r += ps[i];
    writeln(r);
}