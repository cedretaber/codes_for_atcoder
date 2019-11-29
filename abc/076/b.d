import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto K = readln.chomp.to!int;

    auto ret = 1;
    foreach (_; 0..N)
        ret = min(ret * 2, ret + K);
    writeln(ret);
}