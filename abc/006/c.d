import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (c; 0..N+1) {
        auto b = M - N*2 - c*2;
        if (b < 0) continue;
        auto a = N - b - c;
        if (a < 0) continue;
        writefln("%d %d %d", a, b, c);
        return;
    }
    writeln("-1 -1 -1");
}