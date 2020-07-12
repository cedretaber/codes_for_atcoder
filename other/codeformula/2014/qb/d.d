import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 1000000007L;

void main()
{
    auto N = readln.chomp.to!int;
    long r = 1, d = 1, c = 1, o;
    foreach (i; 0..N) {
        auto a = readln.chomp.to!long;
        (c += a * d % P) %= P;
        (d *= 10) %= P;
        o = (a+o)/10;
        if (o == 0) {
            (r *= c) %= P;
            c = 1;
            d = 1;
        }
    }
    if (c != 1) (r *= c) %= P;
    writeln((r-1+P) % P);
}