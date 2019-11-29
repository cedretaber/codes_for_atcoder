import std.stdio, std.conv, std.string, std.array, std.algorithm;

void main()
{
    auto ab = readln.chomp.split(" ").map!(to!int);
    auto a = ab[0];
    auto b = ab[1];
    auto ret = a + b;

    while (ret > 23) ret -= 24;

    writeln(ret);
}