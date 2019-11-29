import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias P = Tuple!(long, "x", long, "y");
P[100] PS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        PS[i] = P(xy[0], xy[1]);
    }
    int r;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            foreach (k; j+1..N) {
                auto a = PS[i];
                auto b = PS[j];
                auto c = PS[k];
                auto s2 = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
                if (s2 != 0 && s2 % 2 == 0) ++r;
            }
        }
    }
    writeln(r);
}