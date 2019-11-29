import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    sort!"a > b"(as);
    long r;
    foreach (i; 0..N*2) if (i%2 == 1) r += as[i];
    writeln(r);
}