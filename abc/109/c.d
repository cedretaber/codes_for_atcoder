import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    auto xs = readln.split.to!(int[]);

    auto d = xs[0];
    X = abs(X - d);
    foreach (x; xs[1..$]) {
        X = gcd(X, abs(x - d));
    }

    writeln(X);
}