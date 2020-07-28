import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias R = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    readln;
    int[R] rs;
    foreach (_; 0..N) {
        auto pqrs = readln.split.to!(int[]);
        auto p = pqrs[0];
        auto q = pqrs[1];
        auto r = pqrs[2]+1;
        auto s = pqrs[3]+1;
        foreach (i; p..r) foreach (j; q..s) ++rs[R(i, j)];
    }

    int max_d;
    foreach (_, d; rs) max_d = max(max_d, d);
    int s;
    foreach (_, d; rs) if (d == max_d) ++s;
    writeln(max_d);
    writeln(s);
}