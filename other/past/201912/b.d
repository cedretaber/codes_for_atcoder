import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new int[](N);
    foreach (i; 0..N) {
        as[i] = readln.chomp.to!int;
    }
    auto a = as[0];
    foreach (b; as[1..$]) {
        auto d = b - a;
        if (d > 0) {
            writefln("up %d", d);
        } else if (d < 0) {
            writefln("down %d", -d);
        } else {
            writeln("stay");
        }
        a = b;
    }
}