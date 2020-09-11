import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, "s", int, "v");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    P[] ps;
    foreach (_; 0..N) {
        auto sv = readln.split.to!(int[]);
        ps ~= P(sv[0], sv[1]);
    }
    sort!"a.v == b.v ? a.s > b.s : a.v > b.v"(ps);
    int[] cs;
    foreach (_; 0..M) {
        cs ~= readln.chomp.to!int;
    }
    sort!"a > b"(cs);

    int i, j, r;
    while (i < N && j < M) {
        if (ps[i].s <= cs[j]) {
            ++i; ++j; ++r;
        } else {
            ++i;
        }
    }
    writeln(r);
}