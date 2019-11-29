import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto n = readln.chomp.to!int;
    if (n == 1) {
        writeln("BOWWOW");
        return;
    }
    auto m = n * (n+1) / 2;
    for (int i = 2; i^^2 <= m; ++i) {
        if (m % i == 0) {
            writeln("BOWWOW");
            return;
        }
    }
    writeln("WANWAN");
}