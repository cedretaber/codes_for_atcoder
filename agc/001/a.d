import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto LS = readln.split.to!(int[]);
    sort(LS);
    int r;
    foreach (i; 0..N) r += LS[i*2];
    writeln(r);
}