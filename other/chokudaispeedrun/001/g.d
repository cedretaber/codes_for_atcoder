import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    readln;
    auto as = readln.split.to!(long[]);
    long s, k = 1;
    foreach_reverse (a; as) {
        s = (s + k * a) % P;
        auto b = a;
        while (b) {
            k = (k * 10) % P;
            b /= 10;
        }
    }
    writeln(s);
}