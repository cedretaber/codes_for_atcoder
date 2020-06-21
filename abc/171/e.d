import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(ulong[]);

    ulong x = as[0];
    foreach (a; as[1..$]) x ^= a;
    ulong[] res;
    foreach (a; as) res ~= a ^ x;
    writeln(res.to!(string[]).join(" "));
}