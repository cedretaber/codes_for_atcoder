import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    sort(as);
    auto x = as[$-1];
    as = as[0..$-1];
    int y, d = int.max;
    foreach (a; as) {
        auto e = abs((x+1)/2 - a);
        if (e < d) {
            y = a;
            d = e;
        }
    }
    writefln("%d %d", x, y);
}