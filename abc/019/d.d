import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int x;
    long max_d;
    foreach (i; 2..N+1) {
        writefln("? %d %d", 1, i);
        stdout.flush();
        auto d = readln.chomp.to!long;
        if (d > max_d) {
            x = i;
            max_d = d;
        }
    }
    foreach (i; 1..N+1) {
        if (i == x) continue;
        writefln("? %d %d", x, i);
        stdout.flush();
        max_d = max(max_d, readln.chomp.to!long);
    }
    writefln("! %d", max_d);
}