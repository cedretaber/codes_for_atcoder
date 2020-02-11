import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    auto AS = readln.split.to!(long[]);
    sort!"a > b"(AS);
    auto r = AS[0] + N;
    foreach (a; AS) r += a;
    writeln(r);
}