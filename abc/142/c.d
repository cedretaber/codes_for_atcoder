import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto r = new int[](N);
    foreach (i, a; readln.split.to!(int[])) r[a-1] = i.to!int+1;
    writeln(r.to!(string[]).join(" "));
}