import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = new int[](N);
    foreach (i; 0..N) {
        auto a = readln.chomp.to!int-1;
        ++cs[a];
    }
    size_t x, y;
    foreach (i, c; cs) {
        if (c == 0) {
            x = i;
        } else if (c == 2) {
            y = i;
        }
    }
    if (x == y) {
        writeln("Correct");
    } else {
        writefln("%d %d", y+1, x+1);
    }
}