import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!long;
    long s;
    foreach (a; 1..K+1) foreach (b; 1..K+1) {
        auto x = gcd(a, b);
        foreach (c; 1..K+1) s += gcd(c, x);
    }
    writeln(s);
}