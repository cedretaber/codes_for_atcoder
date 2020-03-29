import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;
    auto x = (sqrt(N.to!double * 8.0 + 1.0) / 2.0).to!long;
    writeln(x * (x+1) / 2 == N ? x : -1);
}