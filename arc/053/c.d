import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias M = Tuple!(long, "a", long, "b");

void main()
{
    auto N = readln.chomp.to!int;
    M[] ds, us;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto m = M(ab[0], ab[1]);
        if (m.a < m.b) {
            ds ~= m;
        } else {
            us ~= m;
        }
    }
    sort!"a.a < b.a"(ds);
    sort!"a.b > b.b"(us);
    auto ms = ds ~ us;
    long t, max_t;
    foreach (m; ms) {
        t += m.a;
        max_t = max(max_t, t);
        t -= m.b;
    }
    writeln(max_t);
}