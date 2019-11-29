import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    int t = 1, r;
    while (t < B) {
        ++r;
        t = t - 1 + A;
    }
    writeln(r);
}