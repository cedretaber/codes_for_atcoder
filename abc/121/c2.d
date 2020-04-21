import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(long, "a", long, "b");

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    AB[] abs;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        abs ~= AB(ab[0], ab[1]);
    }
    sort!"a.a < b.a"(abs);
    long s;
    for (;;) {
        auto a = abs[0].a;
        auto b = abs[0].b;
        if (M > b) {
            s += a*b;
            M -= b;
        } else {
            s += a*M;
            break;
        }
        abs = abs[1..$];
    }
    writeln(s);
}