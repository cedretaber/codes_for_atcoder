import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;

    long s;
    bool neq;
    long[] AS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto A = ab[0];
        auto B = ab[1];
        s += A;
        if (A >= B) {
            AS ~= A;
            BS ~= B;
        } else {
            neq = true;
        }
    }
    if (!neq) {
        writeln(0);
        return;
    }
    long min_b = long.max;
    foreach (i; 0..AS.length) {
        if (AS[i] != BS[i] && BS[i] < min_b) min_b = BS[i];
    }
    writeln(s - min_b);
}