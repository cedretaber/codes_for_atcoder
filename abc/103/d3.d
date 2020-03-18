import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(int, "a", int, "b");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    AB[] abs;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        abs ~= AB(ab[0]-1, ab[1]-1);
    }
    sort!"a.a < b.a"(abs);
    int n, c = N+1;
    foreach (i; 0..N) {
        if (c == i) {
            ++n;
            c = N+1;
        }
        while (!abs.empty && abs[0].a == i) {
            if (abs[0].b < c) c = abs[0].b;
            abs = abs[1..$];
        }
    }
    writeln(n);
}