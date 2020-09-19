import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;
    long r;
    foreach (a; 1..N) {
        auto b = N/a;
        r += b - (N%a == 0 ? 1 : 0);
    }
    writeln(r);
}