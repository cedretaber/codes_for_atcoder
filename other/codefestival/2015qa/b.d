import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long S;
    foreach (a; readln.split.to!(long[])) S = a + S*2;
    writeln(S);
}