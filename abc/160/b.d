import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!long;
    long r;
    r += X/500 * 1000;
    X -= X/500 * 500;
    r += X/5 * 5;
    writeln(r);
}