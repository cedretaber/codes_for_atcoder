import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = readln.split.to!(int[]);
    hs ~= 0;
    int c;
    foreach (i; 0..N) c += max(0, hs[i] - hs[i+1]);
    writeln(c);
}