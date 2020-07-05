import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;
    long r;
    foreach (i; 1..N+1) {
        r += i * (N-i+1);
    }
    foreach (_; 1..N) {
        auto uv = readln.split.to!(long[]);
        auto u = uv[0];
        auto v = uv[1];
        if (u > v) swap(u, v);
        r -= u * (N-v+1);
    }
    writeln(r);
}