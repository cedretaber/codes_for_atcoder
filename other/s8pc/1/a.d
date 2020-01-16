import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!double;
    writefln("%.010f", 18.0 * 60.0 / (N-1));
}