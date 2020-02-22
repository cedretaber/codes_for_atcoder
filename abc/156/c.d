import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto XS = readln.split.to!(long[]);
    long r = long.max;
    foreach (long p; 0..101) {
        long rr;
        foreach (x; XS) rr += (p - x)^^2;
        r = min(r, rr);
    }
    writeln(r);
}