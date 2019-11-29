import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;
    long s;
    foreach (long i; 0..N) s += N-i;
    writeln(s);
}