import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias OP = Tuple!(long, long);

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    sort(as);

    if (N == 2) {
        writeln(as[1] - as[0]);
        writefln("%d %d", as[1], as[0]);
        return;
    }

    long[] ps, ms;
    long r;
    r += as[$-1];
    r -= as[0];
    foreach (a; as[1..$-1]) {
        if (a < 0) {
            ms ~= a;
            r -= a;
        } else {
            ps ~= a;
            r += a;
        }
    }
    writeln(r);
    if (ps.empty) {
        writefln("%d %d", as[$-1], as[0]);
        r = as[$-1] - as[0];
    } else {
        writefln("%d %d", as[0], as[$-1]);
        r = as[0] - as[$-1];
    }
    while (ps.length > 1) {
        writefln("%d %d", r, ps[0]);
        r -= ps[0];
        ps = ps[1..$];
    }
    if (!ps.empty) {
        writefln("%d %d", ps[0], r);
        r = ps[0] - r;
    }
    while (!ms.empty) {
        writefln("%d %d", r, ms[0]);
        r -= ms[0];
        ms = ms[1..$];
    }
}