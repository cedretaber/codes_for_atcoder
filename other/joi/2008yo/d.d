import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Star = Tuple!(int, "x", int, "y");

void main()
{
    Star[] sign;
    bool[Star] celestia;
    auto M = readln.chomp.to!int;
    int x, y;
    foreach (i; 0..M) {
        auto xy = readln.split.to!(int[]);
        if (i == 0) {
            x = xy[0];
            y = xy[1];
        } else {
            sign ~= Star(xy[0]-x, xy[1]-y);
        }
    }
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        celestia[Star(xy[0], xy[1])] = true;
    }
    foreach (s, _; celestia) {
        foreach (p; sign) {
            if (Star(p.x + s.x, p.y + s.y) !in celestia) goto ng;
        }
        writefln("%d %d", s.x - x, s.y - y);
        ng:
    }
}