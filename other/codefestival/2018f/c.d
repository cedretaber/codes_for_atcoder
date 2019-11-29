import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(long, "a", long, "b");

void main()
{
    auto N = readln.chomp.to!int;
    auto ps = new P[](N);
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        ps[i] = P(ab[0], ab[1]);
    }
    sort!"a.a < b.a"(ps);

    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto t = readln.chomp.to!long;
        if (t < ps[0].a) {
            writeln(ps[0].b);
        } else if (t >= ps[$-1].a) {
            writeln(ps[$-1].b + t - ps[$-1].a);
        } else {
            size_t l, r = ps.length-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (ps[m].a > t) {
                    r = m;
                } else {
                    l = m;
                }
            }
            writeln(min(ps[l].b + t - ps[l].a, ps[r].b));
        }
    }
}