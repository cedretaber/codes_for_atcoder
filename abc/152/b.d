import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(long[]);
    auto a = ab[0];
    auto b = ab[1];
    if (a > b) swap(a, b);
    long r;
    while (b) {
        r *= 10;
        r += a;
        --b;
    }
    writeln(r);
}