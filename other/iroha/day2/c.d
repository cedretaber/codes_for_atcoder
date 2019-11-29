import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Y = Tuple!(int, "i", int, "h");

void main()
{
    auto N = readln.chomp.to!int;
    Y[] ys;
    ys.length = N;
    foreach (i; 0..N) {
        auto h = readln.chomp.to!int;
        ys[i] = Y(i, h);
    }
    sort!"a.h < b.h"(ys);
    int i, last;
    foreach (ref y; ys) {
        if (y.h > last) {
            last = y.h;
            ++i;
        }
        y.h = i;
    }
    sort!"a.i < b.i"(ys);
    foreach (y; ys) writeln(y.h);
}