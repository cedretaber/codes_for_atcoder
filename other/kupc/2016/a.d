import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];
    auto ts = new int[](N);
    foreach (i; 0..N) ts[i] = readln.chomp.to!int;
    int r;
    foreach (t; ts) if (A <= t && t < B) ++r;
    writeln(N - r);
}