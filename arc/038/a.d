import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    sort!"a > b"(AS);
    int s;
    for (size_t i; i < N; i += 2) s += AS[i];
    writeln(s);
}