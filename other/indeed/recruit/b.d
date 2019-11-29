import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias R = Tuple!(int, "a", int, "b");

R[2000] RS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto ab = readln.split.to!(int[]);
        RS[i] = R(ab[0], ab[1]);
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto cd = readln.split.to!(int[]);
        auto c = cd[0];
        auto d = cd[1];
        bool ok = true;
        foreach (r; RS[0..M]) {
            if (!(d < r.a || c > r.b)) {
                ok = false;
                break;
            }
        }
        if (ok) {
            writeln("OK");
            RS[M++] = R(c, d);
        } else {
            writeln("NG");
        }
    }
}