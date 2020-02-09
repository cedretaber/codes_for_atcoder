import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto st = readln.split;
    auto S = st[0];
    auto T = st[1];
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    if (readln.chomp == S) {
        --A;
    } else {
        --B;
    }
    writefln("%d %d", A, B);
}