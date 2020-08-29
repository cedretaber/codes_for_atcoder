import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    long x, r;
    foreach (a; AS) {
        (r += x * a % P) %= P;
        (x += a) %= P;
    }
    writeln(r);
}