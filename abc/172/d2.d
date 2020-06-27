import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!long;
    long r;
    foreach (i; 1..N+1) {
        auto d = N/i;
        r += d * (d+1) / 2 * i;
    }
    writeln(r);
}