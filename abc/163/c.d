import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto js = new int[](N);
    foreach (a; readln.split.to!(int[])) ++js[a-1];
    foreach (j; js) writeln(j);
}