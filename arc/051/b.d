import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto n = readln.chomp.to!int;
    if (n == 1) {
        writeln("1 1");
        return;
    }
    n -= 2;
    auto a = 1, b = 2;
    while (n--) {
        a += b;
        swap(a, b);
    }
    writefln("%d %d", a, b);
}