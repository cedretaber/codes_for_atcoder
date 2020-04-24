import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto vs = readln.split.to!(int[]);
    auto fs = readln.split.to!(int[]);
    int c;
    foreach (i; 0..N) if (fs[i]*2 > vs[i]) ++c;
    writeln(c);
}