import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto xy = readln.chomp.split('/').to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto d = gcd(X, Y);
    X /= d;
    Y /= d;
    long[] ns, ms;
    foreach (n; (2 * X + Y - 1) / Y - 1 .. (2 * X + Y) / Y + 1) {
        auto a = n * (X * -2 + n * Y + Y);
        auto b = 2 * Y;
        if (a && a % b == 0) {
            ns ~= n;
            ms ~= a/b;
        }
    }

    if (ns.empty) {
        writeln("Impossible");
    } else foreach (i; 0..ns.length) {
        writeln(ns[i], " ", ms[i]);
    }
}
