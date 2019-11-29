import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto xyz = readln.split.to!(long[]);
    auto x = xyz[0];
    auto y = xyz[1];
    auto z = xyz[2];
    foreach (long i; 0..10^^7) {
        auto n = P*i + z;
        if (n%17 == x && n%107 == y) {
            writeln(n);
            return;
        }
    }
}