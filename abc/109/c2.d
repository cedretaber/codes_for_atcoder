import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];
    auto xs = readln.split.to!(long[]);
    auto r = abs(xs[0] - X);
    foreach (x; xs[1..$]) {
        r = gcd(r, abs(x - X));
    }
    writeln(r);
}