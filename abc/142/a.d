import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    writefln("%.09f", ((N/2).to!double + (N%2 == 0 ? 0.0 : 1.0)) / N.to!double);
}